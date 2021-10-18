Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA243137B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhJRJbI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 05:31:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41048 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhJRJbH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 05:31:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634549336; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=k5Qbu/k/DMXlZetfhlRBlFSRz2fhehfD4Cj6JfzajWM=; b=NEIH398qSoO8fL05FeSv3WrtF25DP/jz133i0mV6gqmPFK7QLxm05hTPEeROZpJ/v5DPYFYN
 Xx5x5uX7y8ilJrUuLGP6+FRUs6JGZzqAMMKv4SRdryr/50PIu98h/Wig5uPZU8XwFmQpccDa
 SGdDd0XnlLKLUrNxMiePaW+7mhg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 616d3e4130ce13d2b4f1e575 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 09:28:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEDE9C43460; Mon, 18 Oct 2021 09:28:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14449C4338F;
        Mon, 18 Oct 2021 09:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 14449C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-2-emmanuel.grumbach@intel.com>
Date:   Mon, 18 Oct 2021 12:28:26 +0300
In-Reply-To: <20210811105541.43426-2-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 11 Aug 2021 13:55:36 +0300")
Message-ID: <87y26qvg05.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> CSME in two words
> -----------------
> CSME stands for Converged Security and Management Engine. It is
> a CPU on the chipset and runs a dedicated firmware.
> AMT (Active Management Technology) is one of the applications
> that run on that CPU. AMT allows to control the platform remotely.
> Here is a partial list of the use cases:
> * View the screen of the plaform, with keyboard and mouse (KVM)
> * Attach a remote IDE device
> * Have a serial console to the device
> * Query the state of the platform
> * Reset / shut down / boot the platform
>
> Networking in CSME
> ------------------
> For those uses cases, CSME's firmware has an embedded network
> stack and is able to use the network devices of the system: LAN
> and WLAN. This is thanks to the CSME's firmware WLAN driver.
>
> One can add a profile (SSID / key / certificate) to the CSME's OS
> and CSME will connect to that profile. Then, one can use the WLAN
> link to access the applications that run on CSME (AMT is one of
> them). Note that CSME is active during power state and power state
> transitions. For example, it is possible to have a KVM session
> open to the system while the system is rebooting and actually
> configure the BIOS remotely over WLAN thanks to AMT.
>
> How all this is related to Linux
> --------------------------------
> In Linux, there is a driver that allows the OS to talk to the
> CSME firmware, this driver is drivers/misc/mei. This driver
> advertises a bus that allows other kernel drivers or even user
> space) to talk to components inside the CSME firmware.
> In practice, the system advertises a PCI device that allows
> to send / receive data to / from the CSME firmware. The mei
> bus drivers in drivers/misc/mei is an abstration on top of
> this PCI device.
> The driver being added here is called iwlmei and talks to the
> WLAN driver inside the CSME firmware through the mei bus driver.
> Note that the mei bus driver only gives bus services, it doesn't
> define the content of the communication.
>
> Why do we need this driver?
> --------------------------
> CSME uses the same WLAN device that the OS is expecting to see
> hence we need an arbitration mechanism. This is what iwlmei is
> in charge of. iwlmei maintains the communication with the CSME
> firmware's WLAN driver. The language / protocol that is used
> between the CSME's firmware WLAN driver and iwlmei is OS agnostic
> and is called SAP which stands for Software Abritration Protocol.
> With SAP, iwlmei will be able to tell the CSME firmware's WLAN
> driver:
> 1) Please give me the device.
> 2) Please note that the SW/HW rfkill state change.
> 3) Please note that I am now associated to X.
> 4) Please note that I received this packet.
> etc...
>
> There are messages that go the opposite direction as well:
> 1) Please note that AMT is en/disable.
> 2) Please note that I believe the OS is broken and hence I'll take
>    the device *now*, whether you like it or not, to make sure that
>    connectivity is preserved.
> 3) Please note that I am willing to give the device if the OS
>    needs it.
> 4) Please give me any packet that is sent on UDP / TCP on IP address
>    XX.XX.XX.XX and an port ZZ.
> 5) Please send this packet.
> etc...
>
> Please check drivers/net/wireless/intel/iwlwifi/mei/sap.h for the
> full protocol specification.
>
> Arbitration is not the only purpose of iwlmei and SAP. SAP also
> allows to maintain the AMT's functionality even when the OS owns
> the device. To connect to AMT, one needs to initiate an HTTP
> connection to port 16992. iwlmei will listen to the Rx path and
> forward (through SAP) to the CSME firmware the data it got. Then,
> the embedded HTTP server in the chipset will reply to the request
> and send a SAP notification to ask iwlmei to send the reply.
> This way, AMT running on the CSME can still work.
>
> In practice this means that all the use cases quoted above (KVM,
> remote IDE device, etc...) will work even when the OS uses the
> WLAN device.
>
> How to disable all this?
> ---------------------------
> iwlmei won't be able to do anything if the CSME's networking stack
> is not enabled. By default, CSME's networking stack is disabled (this
> is a BIOS setting).
> In case the CSME's networking stack is disabled, iwlwifi will just
> get access to the device because there is no contention with any other
> actor and, hence, no arbitration is needed.
>
> In this patch, I only add the iwlmei driver. Integration with
> iwlwifi will be implemented in the next one.
>
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Comments for main.c:

> --- /dev/null
> +++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
> @@ -0,0 +1,1872 @@
> +// SPDX-License-Identifier: GPL-2.0

Someconsistency with the license within iwlwifi would be nice, I see
that elsewhere in iwlwifi GPL-2.0-only is used instead of GPL-2.0:

grep -rh SPDX * | sort | uniq --count
      4 # SPDX-License-Identifier: GPL-2.0
      6 // SPDX-License-Identifier: GPL-2.0
      1 # SPDX-License-Identifier: GPL-2.0-only
     15 /* SPDX-License-Identifier: GPL-2.0-only */
     22 // SPDX-License-Identifier: GPL-2.0-only
     73 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
     62 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

> +/*
> + * Since iwlwifi calls iwlmei without any context, hold a pointer to the
> + * mei_cl_device structure here.
> + * Define a mutex that will synchronize all the flows between iwlwifi and
> + * iwlmei.
> + */
> +static struct mei_cl_device *iwl_mei_global_cldev;
> +static DEFINE_MUTEX(iwl_mei_mutex);
> +static unsigned long iwl_mei_status;

static non-const variables are frowned upon in upstream. What if there
are multiple iwlwifi devices attached to the same host, how would this
work then?

> +/**
> + * iwl_mei_cache - cache for the parameters from iwlwifi
> + * @ops: Callbacks to iwlwifi.
> + * @netdev: The netdev that will be used to transmit / receive packets.
> + * @conn_info: The connection info message triggered by iwlwifi's association.
> + * @power_limit: pointer to an array of 10 elements (le16) represents the power
> + *	restrictions per chain.
> + * @rf_kill: rf kill state.
> + * @mcc: MCC info
> + * @mac_address: interface MAC address.
> + * @nvm_address: NVM MAC address.
> + * @priv: A pointer to iwlwifi.
> + *
> + * This used to cache the configurations coming from iwlwifi's way. The data
> + * is cached here so that we can buffer the configuration even if we don't have
> + * a bind from the mei bus and hence, on iwl_mei structure.
> + */
> +static struct {
> +	const struct iwl_mei_ops *ops;
> +	struct net_device __rcu *netdev;
> +	const struct iwl_sap_notif_connection_info *conn_info;
> +	const __le16 *power_limit;
> +	u32 rf_kill;
> +	u16 mcc;
> +	u8 mac_address[6];
> +	u8 nvm_address[6];
> +	void *priv;
> +} iwl_mei_cache = {
> +	.rf_kill = SAP_HW_RFKILL_DEASSERTED | SAP_SW_RFKILL_DEASSERTED
> +};

Same here, this is also static but non-const.

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
> +	if (!netdev)
> +		return;
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
> +			dev_err(&cldev->dev,
> +				"Data queue is corrupted: valid data len %zd, len %d\n",
> +				valid_rx_sz, len);
> +			break;
> +		}
> +
> +		if (len < sizeof(*ethhdr)) {
> +			dev_err(&cldev->dev,
> +				"Data len is smaller than an ethernet header? len = %d\n",
> +				len);
> +		}
> +
> +		valid_rx_sz -= len;
> +
> +		if (le16_to_cpu(hdr.type) != SAP_MSG_DATA_PACKET) {
> +			dev_err(&cldev->dev, "Unsupported Rx data: type %d, len %d\n",
> +				le16_to_cpu(hdr.type), len);
> +			continue;
> +		}
> +
> +		/* We need enough room for the WiFi header + SNAP + IV */
> +		skb = netdev_alloc_skb(netdev, len + 26 + 8 + 8);
> +
> +		skb_reserve(skb, 26 + 8 + 8);

No magic numbers, please.

> +static void iwl_mei_remove(struct mei_cl_device *cldev)
> +{
> +	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
> +	int i;
> +
> +	/*
> +	 * We are being removed while the bus is active, it means we are
> +	 * going to suspend/ shutdown, so the NIC will disappear.
> +	 */
> +	if (mei_cldev_enabled(cldev) && iwl_mei_cache.ops)
> +		iwl_mei_cache.ops->nic_stolen(iwl_mei_cache.priv);
> +
> +	if (rcu_access_pointer(iwl_mei_cache.netdev)) {
> +		struct net_device *dev;
> +
> +		/*
> +		 * If we are suspending and the wifi driver hasn't removed it's netdev
> +		 * yet, do it now. In any case, don't change the cache.netdev pointer.
> +		 */
> +		dev = rcu_dereference_protected(iwl_mei_cache.netdev,
> +						lockdep_is_held(&iwl_mei_mutex));
> +
> +		rtnl_lock();
> +		netdev_rx_handler_unregister(dev);
> +		rtnl_unlock();
> +	}
> +
> +	mutex_lock(&iwl_mei_mutex);
> +
> +	/*
> +	 * Tell CSME that we are going down so that it won't access the
> +	 * memory anymore, make sure this message goes through immediately.
> +	 */
> +	mei->csa_throttled = false;
> +	iwl_mei_send_sap_msg(mei->cldev,
> +			     SAP_MSG_NOTIF_HOST_GOES_DOWN);
> +
> +	for (i = 0; i < 10; i++) {

Same here, a magic number.

> +		if (!iwl_mei_host_to_me_data_pending(mei))
> +			break;
> +
> +		msleep(5);
> +	}
> +
> +	/*
> +	 * If we couldn't make sure that CSME saw the HOST_GOES_DOWN message,
> +	 * it means that it will probably keep reading memory that we are going
> +	 * to unmap and free, expect IOMMU error messages.
> +	 */
> +	if (i == 10)
> +		dev_err(&mei->cldev->dev,
> +			"Couldn't get ACK from CSME on HOST_GOES_DOWN message\n");

And here.

> +static struct mei_cl_device_id iwl_mei_tbl[] = {
> +	{ KBUILD_MODNAME, MEI_WLAN_UUID, MEI_CL_VERSION_ANY},
> +
> +	/* required last entry */
> +	{ }
> +};

This can be const, right?

> +
> +/*
> + * Do not export the device table because this module is loaded by
> + * iwlwifi's dependency.
> + */
> +
> +static struct mei_cl_driver iwl_mei_cl_driver = {
> +	.id_table = iwl_mei_tbl,
> +	.name = KBUILD_MODNAME,
> +	.probe = iwl_mei_probe,
> +	.remove = iwl_mei_remove,
> +};
> +
> +module_mei_cl_driver(iwl_mei_cl_driver);

Not sure iwl_mei_cl_driver can be const or not, most probably not. But
please do check.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
