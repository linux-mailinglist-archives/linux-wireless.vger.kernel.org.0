Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66C135C6FF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 15:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbhDLNGl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 09:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239552AbhDLNGl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 09:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 497A461261;
        Mon, 12 Apr 2021 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618232781;
        bh=pqkLfowKzi0bCsj0Ikt21si49f+9xZCOxBzc4dZPXdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuYlYrrB9jfcKgHaqLks6EI8k3eFz/Kd8F6/MzCusXlxtlnczoTKFsMSZ06mfGpwV
         fVOAxVsOLOHD1LeOI1Ymj68Aq4xPMtzqCCWkoDWKe6VTXekmelPB5tu3i1OcA2+k1e
         HCc6+nP/cYDIRTTDKy7N9CSuYXwBSCN3Kb0GBisA=
Date:   Mon, 12 Apr 2021 15:06:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Ayala Beker <ayala.beker@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Message-ID: <YHRFy3aq/gB7Vde6@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-2-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412124328.24472-2-emmanuel.grumbach@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 03:43:27PM +0300, Emmanuel Grumbach wrote:
> iwlmei is a driver that handles the communication with the
> Wireless driver of the CSME firmware.
> More details in the documentation included in this patch.
> 
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/Kconfig    |   13 +
>  drivers/net/wireless/intel/iwlwifi/Makefile   |    2 +
>  .../net/wireless/intel/iwlwifi/mei/Makefile   |    8 +
>  .../net/wireless/intel/iwlwifi/mei/internal.h |   20 +
>  .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  440 ++++
>  drivers/net/wireless/intel/iwlwifi/mei/main.c | 2026 +++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/mei/net.c  |  409 ++++
>  drivers/net/wireless/intel/iwlwifi/mei/sap.h  |  736 ++++++
>  .../wireless/intel/iwlwifi/mei/trace-data.h   |   69 +
>  .../net/wireless/intel/iwlwifi/mei/trace.c    |   15 +
>  .../net/wireless/intel/iwlwifi/mei/trace.h    |   62 +
>  11 files changed, 3800 insertions(+)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/Makefile
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/internal.h
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/main.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/net.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/sap.h
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.h
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
> index 1085afbefba8..eb68f93bbe90 100644
> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -92,6 +92,19 @@ config IWLWIFI_BCAST_FILTERING
>  	  If unsure, don't enable this option, as some programs might
>  	  expect incoming broadcasts for their normal operations.
>  
> +config IWLMEI
> +	tristate "Enable V-PRO for WLAN"
> +	depends on INTEL_MEI
> +	depends on IWLMVM
> +	help
> +	  Enable V-PRO. This allows to communicate with the CSME firmware.
> +	  This is supported starting from Tiger Lake platforms and has been
> +	  tested on 9260 devices only. Enabling this option on a platform that
> +	  has a different device and has Wireless enabled on AMT can prevent
> +	  WiFi from working correctly.

What does any of that mean?  I can't understand it at all, and here I
thought I understand new hardware terms :(

> +
> +	  If unsure, say N.

module name?


> +
>  menu "Debugging Options"
>  
>  config IWLWIFI_DEBUG
> diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
> index 14b0db28143b..ff4d4b651c3e 100644
> --- a/drivers/net/wireless/intel/iwlwifi/Makefile
> +++ b/drivers/net/wireless/intel/iwlwifi/Makefile
> @@ -30,4 +30,6 @@ ccflags-y += -I$(src)
>  obj-$(CONFIG_IWLDVM)	+= dvm/
>  obj-$(CONFIG_IWLMVM)	+= mvm/
>  
> +obj-$(CONFIG_IWLMEI)	+= mei/

Cuddle up against the line above?

> --- /dev/null
> +++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
> @@ -0,0 +1,2026 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

I didn't think that Intel was doing dual-license for .c files in the
kernel, especially for ones that call GPL-only kernel symbols :(

The "loonacy" of doing this for .h files kind of makes sense if you
really squint, but even then, it's crazy.  But for .c files like this,
that's not good.

You all have the right to license the code under whatever you want, so
why keep a BSD license on it when it goes into the kernel tree?

In the past, I have been told by various Intel lawyers/legal-types that
they were not going to do this anymore.  I know things change, but are
you sure that this is ok with the current corporate position of Linux
kernel code that calls other parts of the core kernel like this?

Same for all new files in this patchset.


> +/*
> + * Copyright (C) 2021 Intel Corporation
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/netdevice.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mei_cl_bus.h>
> +#include <linux/rcupdate.h>
> +#include <linux/debugfs.h>
> +#include <linux/skbuff.h>
> +#include <linux/wait.h>
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +
> +#include "internal.h"
> +#include "iwl-mei.h"
> +#include "trace.h"
> +#include "trace-data.h"
> +#include "sap.h"
> +
> +MODULE_DESCRIPTION("The Intel(R) wireless / CSME firmware interface");
> +MODULE_LICENSE("GPL");
> +
> +#define CHECK_FOR_NEWLINE(f) BUILD_BUG_ON(f[sizeof(f) - 2] != '\n')
> +
> +#define IWL_MEI_DEBUG(c, f, a...)		\
> +	do {					\
> +		CHECK_FOR_NEWLINE(f);		\

Huh?

> +		dev_dbg(&(c)->dev, f, ## a);	\

Just use dev_dbg(), don't be special for a single driver, it hurts when
trying to read different drivers.


> +	} while (0)
> +
> +#define IWL_MEI_INFO(c, f, a...)		\
> +	do {					\
> +		CHECK_FOR_NEWLINE(f);		\
> +		dev_info(&(c)->dev, f, ## a);	\
> +	} while (0)
> +
> +#define IWL_MEI_ERR(c, f, a...)			\
> +	do {					\
> +		CHECK_FOR_NEWLINE(f);		\
> +		dev_err(&(c)->dev, f, ## a);	\
> +	} while (0)

Same for all of the above, just use dev_info() and dev_err() please.

> +
> +#define MEI_WLAN_UUID UUID_LE(0x13280904, 0x7792, 0x4fcb, \
> +			      0xa1, 0xaa, 0x5e, 0x70, 0xcb, 0xb1, 0xe8, 0x65)
> +
> +/*
> + * Since iwlwifi calls iwlmei without any context, hold a pointer to the
> + * mei_cl_device structure here.
> + * Define a mutex that will synchronize all the flows between iwlwifi and
> + * iwlmei.
> + */
> +static struct mei_cl_device *iwl_mei_global_cldev;
> +static DEFINE_MUTEX(iwl_mei_mutex);
> +static unsigned long iwl_mei_status;
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static bool defer_start_message;
> +
> +module_param_named(defer_start_message, defer_start_message, bool, 0644);
> +MODULE_PARM_DESC(defer_start_message,
> +		 "Defer the start message Tx to CSME (default false)");

Why do you need this?  Who is going to set it to anything else, and why
would they?  This isn't the 1990's anymore, please do not add new module
parameters.


> +#endif
> +
> +enum iwl_mei_status_bits {
> +	IWL_MEI_STATUS_SAP_CONNECTED,
> +};
> +
> +bool iwl_mei_is_connected(void)
> +{
> +	return test_bit(IWL_MEI_STATUS_SAP_CONNECTED, &iwl_mei_status);
> +}
> +EXPORT_SYMBOL(iwl_mei_is_connected);

EXPORT_SYMBOL_GPL()?  I have to ask... :)


> +struct iwl_mei {
> +	wait_queue_head_t get_nvm_wq;
> +	struct work_struct send_csa_msg_wk;
> +	wait_queue_head_t get_ownership_wq;
> +	struct iwl_mei_shared_mem_ptrs shared_mem;
> +	struct mei_cl_device *cldev;
> +	struct iwl_mei_nvm *nvm;
> +	struct iwl_mei_filters __rcu *filters;
> +	bool got_ownership;
> +	bool amt_enabled;
> +	bool csa_throttled;
> +	bool csme_taking_ownership;
> +	struct delayed_work csa_throttle_end_wk;
> +	spinlock_t data_q_lock;
> +
> +	atomic_t sap_seq_no;
> +	atomic_t seq_no;
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +	struct dentry *dbgfs_dir;
> +	wait_queue_head_t debugfs_wq;
> +	bool ping_pending;
> +#endif

Why #ifdef?  Does the size really matter?

> +static ssize_t iwl_mei_write_cyclic_buf(struct mei_cl_device *cldev,
> +					struct iwl_sap_q_ctrl_blk *notif_q,
> +					u8 *q_head,
> +					const struct iwl_sap_hdr *hdr)
> +{
> +	u32 rd = le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
> +	u32 wr = le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
> +	u32 q_sz = le32_to_cpu(notif_q->size);
> +	size_t room_in_buf;
> +	size_t tx_sz = sizeof(*hdr) + le16_to_cpu(hdr->len);
> +
> +	if (WARN_ON(rd > q_sz || wr > q_sz))
> +		return -EINVAL;

If any of the WARN_ON() things in this driver can ever trigger, just
handle them normally and do NOT call WARN_ON() as you just rebooted the
box for a simple thing that you could have recovered from.

Some of these WARN_ON() in the code feel very lazy as you control the
caller so you "know" that this will never happen.  So don't leave them
in, it's debugging code that you can now remove.

> +
> +	room_in_buf = wr >= rd ? q_sz - wr + rd : rd - wr;
> +
> +	/* we don't have enough room for the data to write */
> +	if (WARN_ON(room_in_buf < tx_sz))
> +		return -ENOSPC;

Can userspace trigger this?  If so, again, you just crashed the machine
when panic_on_warn is enabled.

Just do a real check and handle the issue.

> +static void
> +iwl_mei_handle_rx_start_ok(struct mei_cl_device *cldev,
> +			   const struct iwl_sap_me_msg_start_ok *rsp,
> +			   ssize_t len)
> +{
> +	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
> +
> +	if (len != sizeof(*rsp)) {
> +		IWL_MEI_ERR(cldev,
> +			    "got invalid SAP_ME_MSG_START_OK from CSME firmware\n");
> +		IWL_MEI_ERR(cldev,
> +			    "size is incorrect: %ld instead of %lu\n",
> +			    len, sizeof(*rsp));
> +		return;
> +	}
> +
> +	if (rsp->supported_version != SAP_VERSION) {
> +		IWL_MEI_ERR(cldev,
> +			    "didn't get the expected version: got %d\n",
> +			    rsp->supported_version);
> +		return;
> +	}
> +
> +	IWL_MEI_INFO(cldev,
> +		     "Got a valid SAP_ME_MSG_START_OK from CSME firmware\n");

When drivers work properly, they are quiet.  This is very noisy, please
remove debugging code like this.

> +
> +	mutex_lock(&iwl_mei_mutex);
> +	set_bit(IWL_MEI_STATUS_SAP_CONNECTED, &iwl_mei_status);
> +	/* wifi driver has registered already */
> +	if (iwl_mei_cache.ops) {
> +		WARN_ON(iwl_mei_send_sap_msg(mei->cldev,
> +					     SAP_MSG_NOTIF_WIFIDR_UP));

Why????

> +		iwl_mei_cache.ops->sap_connected(iwl_mei_cache.priv);
> +	}
> +
> +	mutex_unlock(&iwl_mei_mutex);
> +}
> +
> +static void iwl_mei_handle_csme_filters(struct mei_cl_device *cldev,
> +					const struct iwl_sap_csme_filters *filters)
> +{
> +	struct iwl_mei *mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
> +	struct iwl_mei_filters *new_filters;
> +	struct iwl_mei_filters *old_filters;
> +
> +	IWL_MEI_DEBUG(cldev, "Got CSME filters\n");

ftrace is your friend, remove these pointless "the code got here!"
lines.  You have loads of them...

> +static void iwl_mei_handle_rx_host_own_req(struct mei_cl_device *cldev,
> +					   const struct iwl_sap_msg_dw *dw)
> +{
> +	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
> +
> +	IWL_MEI_DEBUG(cldev, "Got ownership req response: %d\n", dw->val);

Code got here!  :(

> +
> +	if (!dw->val) {
> +		IWL_MEI_INFO(cldev, "Ownership req denied\n");

why?????

> +		return;

No error returned?

> +	}
> +
> +	mei->got_ownership = true;
> +	wake_up_all(&mei->get_ownership_wq);
> +
> +	iwl_mei_send_sap_msg(cldev,
> +			     SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED);
> +
> +	/* We can now start the connection, unblock rfkill */
> +	if (iwl_mei_cache.ops)
> +		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
> +}
> +
> +static void iwl_mei_handle_pong(struct mei_cl_device *cldev,
> +				const void *payload)
> +{
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
> +
> +	mei->ping_pending = false;
> +	wake_up_interruptible_all(&mei->debugfs_wq);
> +#endif

Why is this dependant on debugfs?

> +
> +	IWL_MEI_DEBUG(cldev, "Got PONG\n");

again, ftrace.

> +static void iwl_mei_handle_sap_data(struct mei_cl_device *cldev,
> +				    const u8 *q_head, u32 q_sz,
> +				    u32 rd, u32 wr, ssize_t valid_rx_sz,
> +				    struct sk_buff_head *tx_skbs)
> +{
> +	struct iwl_sap_hdr hdr;
> +	struct net_device *netdev =
> +		rcu_dereference_protected(iwl_mei_cache.netdev,
> +					  lockdep_is_held(&iwl_mei_mutex));
> +
> +	if (!netdev) {
> +		IWL_MEI_INFO(cldev, "No netdevice, dropping the Tx packet\n");

quiet!!!

Or at the least, make this an error so that a user can handle it
properly.  They can do something about this, right?  If not, why did you
just tell them this happened?

> +		return;

No error value?

> +	}
> +
> +	while (valid_rx_sz >= sizeof(hdr)) {
> +		struct ethhdr *ethhdr;
> +		unsigned char *data;
> +		struct sk_buff *skb;
> +		u16 len;
> +
> +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, &hdr, sizeof(hdr));
> +		valid_rx_sz -= sizeof(hdr);
> +		len = le16_to_cpu(hdr.len);
> +
> +		if (valid_rx_sz < len) {
> +			IWL_MEI_ERR(cldev,
> +				    "Data queue is corrupted: valid data len %ld, len %d\n",
> +				    valid_rx_sz, len);

What can be done if this happens?

> +			break;
> +		}
> +
> +		if (len < sizeof(*ethhdr)) {
> +			IWL_MEI_ERR(cldev,
> +				    "Data len is smaller than an ethernet header? len = %d\n",
> +				    len);
> +		}
> +
> +		valid_rx_sz -= len;
> +
> +		if (le16_to_cpu(hdr.type) != SAP_MSG_DATA_PACKET) {
> +			IWL_MEI_INFO(cldev, "Unsupported message: type %d, len %d\n",
> +				     le16_to_cpu(hdr.type), len);

So userspace can spam the kernel log?

Please revisit _ALL_ of your messages you are printing out here, it
feels way way way too noisy, like you got the code up and working with
the debug lines in it and forgot to remove it.

How did this get missed in the internal Intel reviews that of course was
required to happen before sending it to others outside of the firewall
to review?

> +			continue;
> +		}
> +
> +		/* We need enough room for the WiFi header + SNAP + IV */
> +		skb = netdev_alloc_skb(netdev, len + 26 + 8 + 8);
> +
> +		skb_reserve(skb, 26 + 8 + 8);
> +		ethhdr = skb_push(skb, sizeof(*ethhdr));
> +
> +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr,
> +				    ethhdr, sizeof(*ethhdr));
> +		len -= sizeof(*ethhdr);
> +
> +		skb_reset_mac_header(skb);
> +		skb_reset_network_header(skb);
> +		skb->protocol = ethhdr->h_proto;
> +
> +		/* we don't really want to get anything besides 802.3 packets */
> +		WARN_ON_ONCE(!eth_proto_is_802_3(ethhdr->h_proto));
> +
> +		data = skb_put(skb, len);
> +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, data, len);
> +
> +		/*
> +		 * Enqueue the skb here so that it can be sent later when we
> +		 * do not hold the mutex. TX'ing a packet with a mutex held is
> +		 * possible, but it wouldn't be nice to forbid the TX path to
> +		 * call any of iwlmei's functions, since every API from iwlmei
> +		 * needs the mutex.
> +		 */
> +		__skb_queue_tail(tx_skbs, skb);
> +	}
> +}
> +
> +static void iwl_mei_handle_sap_rx_cmd(struct mei_cl_device *cldev,
> +				      const u8 *q_head, u32 q_sz,
> +				      u32 rd, u32 wr, ssize_t valid_rx_sz)
> +{
> +	struct page *p = alloc_page(GFP_KERNEL);
> +	struct iwl_sap_hdr *hdr;
> +
> +	if (!p)
> +		return;
> +
> +	hdr = page_address(p);
> +
> +	while (valid_rx_sz >= sizeof(*hdr)) {
> +		u16 len;
> +
> +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, hdr, sizeof(*hdr));
> +		valid_rx_sz -= sizeof(*hdr);
> +		len = le16_to_cpu(hdr->len);
> +
> +		if (valid_rx_sz < len)
> +			break;
> +
> +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, hdr + 1, len);
> +
> +		trace_iwlmei_sap_cmd(hdr, false);
> +		iwl_mei_handle_sap_msg(cldev, hdr);
> +		valid_rx_sz -= len;
> +	}
> +
> +	/* valid_rx_sz must be 0 now... */
> +	WARN_ON_ONCE(valid_rx_sz);

reboot!

{sigh}

<snip>

> +static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
> +{
> +	mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);

At the root of debugfs, bold move :)

> +
> +	if (!mei->dbgfs_dir)
> +		return;

Why check this?  Just feed the result back into other debugfs_create()
calls, no need to care.

And why save the directory name at all, can't you just look it up when
you want to remove it anyway?

> +
> +	init_waitqueue_head(&mei->debugfs_wq);
> +
> +	debugfs_create_ulong("status", S_IRUSR,
> +			     mei->dbgfs_dir, &iwl_mei_status);
> +	debugfs_create_file("ping", S_IRUSR, mei->dbgfs_dir,
> +			    mei, &iwl_mei_dbgfs_ping_ops);
> +	debugfs_create_file("send_start_message", S_IWUSR, mei->dbgfs_dir,
> +			    mei, &iwl_mei_dbgfs_send_start_message_ops);
> +	debugfs_create_file("req_ownserhip", S_IWUSR, mei->dbgfs_dir,
> +			    mei, &iwl_mei_dbgfs_req_ownership_ops);
> +}
> +
> +static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei)
> +{
> +	debugfs_remove_recursive(mei->dbgfs_dir);
> +	mei->dbgfs_dir = NULL;

Why set this to NULL?

> +}
> +
> +#else
> +
> +static void iwl_mei_dbgfs_register(struct iwl_mei *mei) {}
> +static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}

This type of thing goes in a .h file, you know better.


> +
> +#endif /* CONFIG_DEBUG_FS */
> +
> +/**
> + * iwl_mei_probe - the probe function called by the mei bus enumeration
> + *
> + * This allocates the data needed by iwlmei and sets a pointer to this data
> + * into the mei_cl_device's drvdata.
> + * It starts the SAP protocol by sending the SAP_ME_MSG_START without
> + * waiting for the answer. The answer will be caught later by the Rx callback.
> + */
> +static int iwl_mei_probe(struct mei_cl_device *cldev,
> +			 const struct mei_cl_device_id *id)
> +{
> +	struct iwl_mei *mei;
> +	int ret;
> +
> +	mei = devm_kzalloc(&cldev->dev, sizeof(*mei), GFP_KERNEL);
> +	if (!mei)
> +		return -ENOMEM;
> +
> +	init_waitqueue_head(&mei->get_nvm_wq);
> +	INIT_WORK(&mei->send_csa_msg_wk, iwl_mei_send_csa_msg_wk);
> +	INIT_DELAYED_WORK(&mei->csa_throttle_end_wk,
> +			  iwl_mei_csa_throttle_end_wk);
> +	init_waitqueue_head(&mei->get_ownership_wq);
> +	spin_lock_init(&mei->data_q_lock);
> +
> +	mei_cldev_set_drvdata(cldev, mei);
> +	mei->cldev = cldev;
> +
> +	ret = iwl_mei_alloc_shared_mem(cldev);
> +	if (ret)
> +		goto free;
> +
> +	iwl_mei_init_shared_mem(mei);
> +
> +	ret = iwl_mei_enable(cldev);
> +	if (ret)
> +		goto free_shared_mem;
> +
> +	iwl_mei_dbgfs_register(mei);
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)

#if should not be in .c files, again, you all know better...

I'm giving up here, sorry, I can't do it anymore...

greg k-h
