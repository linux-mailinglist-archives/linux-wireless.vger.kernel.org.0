Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A838165F3C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2020 14:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgBTNx7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 08:53:59 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.51]:41193 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgBTNx6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 08:53:58 -0500
X-Greylist: delayed 1457 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 08:53:57 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 2429D3F09
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2020 07:26:26 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 4lqUjWqlPSl8q4lqUjDCYW; Thu, 20 Feb 2020 07:26:26 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6J84MBeCdQLzfeiSeo8Y1ThSIemYlFwtAHSXsSX6lv0=; b=ky5F7F2xIbcmlLjeJpgQVjAdUK
        rsux4XakoDz2WE9MqurVR1xRzyiajbRig5AkP53QD3kFYEkdxHhrJOs2c3CeUACQgIQqalyrPESN2
        CTbnUV5yIx3UhKY/tOM9PvR5xkWdPh0/QqayMYp6g31gwfJBBMhXRcRsBofn7GCNLz8J6q+lQPOtJ
        o4ysTmFrOjPVsNJkT8rbMmgREjrKtvq4PhdVG/xBwlu6cpHReUeOY5fZ5nbHRCutD7V/JSGjWBHXk
        ffuLyMRYJmftHY1bK3nxa5FASfWEn2z+5fMFheBlOasMnTLC8fnhix6K3mXpHi2jv8M/u1+vV84a7
        ZJd2fVfg==;
Received: from [201.144.174.47] (port=24243 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j4lqR-003dLZ-U0; Thu, 20 Feb 2020 07:26:24 -0600
Date:   Thu, 20 Feb 2020 07:29:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: Replace zero-length array with flexible-array member
Message-ID: <20200220132908.GA30501@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.144.174.47
X-Source-L: No
X-Exim-ID: 1j4lqR-003dLZ-U0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.144.174.47]:24243
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 42
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/gdm724x/gdm_mux.h             |  2 +-
 drivers/staging/gdm724x/hci_packet.h          |  6 ++--
 drivers/staging/greybus/audio_apbridgea.h     |  2 +-
 drivers/staging/ks7010/ks_hostif.h            |  4 +--
 .../staging/media/allegro-dvt/allegro-core.c  |  2 +-
 drivers/staging/octeon-usb/octeon-hcd.c       |  2 +-
 drivers/staging/rtl8192e/rtllib.h             | 30 +++++++++----------
 .../staging/rtl8192u/ieee80211/ieee80211.h    | 28 ++++++++---------
 drivers/staging/rtl8712/ieee80211.h           |  4 +--
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h    |  4 +--
 drivers/staging/wilc1000/cfg80211.c           | 10 +++----
 drivers/staging/wilc1000/spi.c                |  2 +-
 drivers/staging/wlan-ng/hfa384x.h             |  4 +--
 drivers/staging/wlan-ng/p80211types.h         |  4 +--
 14 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_mux.h b/drivers/staging/gdm724x/gdm_mux.h
index 51c22e3d8aeb..87b8d921fdc8 100644
--- a/drivers/staging/gdm724x/gdm_mux.h
+++ b/drivers/staging/gdm724x/gdm_mux.h
@@ -29,7 +29,7 @@ struct mux_pkt_header {
 	__le32 seq_num;
 	__le32 payload_size;
 	__le16 packet_type;
-	unsigned char data[0];
+	unsigned char data[];
 };
 
 struct mux_tx {
diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
index 6dea3694afdd..faecdfbc664f 100644
--- a/drivers/staging/gdm724x/hci_packet.h
+++ b/drivers/staging/gdm724x/hci_packet.h
@@ -28,7 +28,7 @@
 struct hci_packet {
 	__dev16 cmd_evt;
 	__dev16 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct tlv {
@@ -51,7 +51,7 @@ struct sdu {
 	__dev32 dft_eps_ID;
 	__dev32 bearer_ID;
 	__dev32 nic_type;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct multi_sdu {
@@ -59,7 +59,7 @@ struct multi_sdu {
 	__dev16 len;
 	__dev16 num_packet;
 	__dev16 reserved;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct hci_pdn_table_ind {
diff --git a/drivers/staging/greybus/audio_apbridgea.h b/drivers/staging/greybus/audio_apbridgea.h
index 3f1f4dd2c61a..efec0f815efd 100644
--- a/drivers/staging/greybus/audio_apbridgea.h
+++ b/drivers/staging/greybus/audio_apbridgea.h
@@ -65,7 +65,7 @@
 struct audio_apbridgea_hdr {
 	__u8	type;
 	__le16	i2s_port;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 struct audio_apbridgea_set_config_request {
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index ca7dc8f5166c..39138191a556 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -70,7 +70,7 @@ struct hostif_data_request {
 #define TYPE_DATA 0x0000
 #define TYPE_AUTH 0x0001
 	__le16 reserved;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 #define TYPE_PMK1 0x0001
@@ -194,7 +194,7 @@ enum mib_data_type {
 struct hostif_mib_value {
 	__le16 size;
 	__le16 type;
-	u8 body[0];
+	u8 body[];
 } __packed;
 
 struct hostif_mib_get_confirm_t {
diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index 3be41698df4c..0a09b3622e78 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -434,7 +434,7 @@ struct mcu_msg_push_buffers_internal_buffer {
 struct mcu_msg_push_buffers_internal {
 	struct mcu_msg_header header;
 	u32 channel_id;
-	struct mcu_msg_push_buffers_internal_buffer buffer[0];
+	struct mcu_msg_push_buffers_internal_buffer buffer[];
 } __attribute__ ((__packed__));
 
 struct mcu_msg_put_stream_buffer {
diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index 582c9187559d..61471a19d4e6 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -406,7 +406,7 @@ struct octeon_hcd {
  */
 struct octeon_temp_buffer {
 	void *orig_buffer;
-	u8 data[0];
+	u8 data[];
 };
 
 static inline struct usb_hcd *octeon_to_hcd(struct octeon_hcd *p)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 328f410daa03..b84f00b8d18b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -728,14 +728,14 @@ struct rtllib_pspoll_hdr {
 struct rtllib_hdr {
 	__le16 frame_ctl;
 	__le16 duration_id;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtllib_hdr_1addr {
 	__le16 frame_ctl;
 	__le16 duration_id;
 	u8 addr1[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtllib_hdr_2addr {
@@ -743,7 +743,7 @@ struct rtllib_hdr_2addr {
 	__le16 duration_id;
 	u8 addr1[ETH_ALEN];
 	u8 addr2[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtllib_hdr_3addr {
@@ -753,7 +753,7 @@ struct rtllib_hdr_3addr {
 	u8 addr2[ETH_ALEN];
 	u8 addr3[ETH_ALEN];
 	__le16 seq_ctl;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtllib_hdr_4addr {
@@ -764,7 +764,7 @@ struct rtllib_hdr_4addr {
 	u8 addr3[ETH_ALEN];
 	__le16 seq_ctl;
 	u8 addr4[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtllib_hdr_3addrqos {
@@ -775,7 +775,7 @@ struct rtllib_hdr_3addrqos {
 	u8 addr3[ETH_ALEN];
 	__le16 seq_ctl;
 	__le16 qos_ctl;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtllib_hdr_4addrqos {
@@ -787,13 +787,13 @@ struct rtllib_hdr_4addrqos {
 	__le16 seq_ctl;
 	u8 addr4[ETH_ALEN];
 	__le16 qos_ctl;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtllib_info_element {
 	u8 id;
 	u8 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct rtllib_authentication {
@@ -802,7 +802,7 @@ struct rtllib_authentication {
 	__le16 transaction;
 	__le16 status;
 	/*challenge*/
-	struct rtllib_info_element info_element[0];
+	struct rtllib_info_element info_element[];
 } __packed;
 
 struct rtllib_disauth {
@@ -818,7 +818,7 @@ struct rtllib_disassoc {
 struct rtllib_probe_request {
 	struct rtllib_hdr_3addr header;
 	/* SSID, supported rates */
-	struct rtllib_info_element info_element[0];
+	struct rtllib_info_element info_element[];
 } __packed;
 
 struct rtllib_probe_response {
@@ -829,7 +829,7 @@ struct rtllib_probe_response {
 	/* SSID, supported rates, FH params, DS params,
 	 * CF params, IBSS params, TIM (if beacon), RSN
 	 */
-	struct rtllib_info_element info_element[0];
+	struct rtllib_info_element info_element[];
 } __packed;
 
 /* Alias beacon for probe_response */
@@ -840,7 +840,7 @@ struct rtllib_assoc_request_frame {
 	__le16 capability;
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
-	struct rtllib_info_element info_element[0];
+	struct rtllib_info_element info_element[];
 } __packed;
 
 struct rtllib_assoc_response_frame {
@@ -848,7 +848,7 @@ struct rtllib_assoc_response_frame {
 	__le16 capability;
 	__le16 status;
 	__le16 aid;
-	struct rtllib_info_element info_element[0]; /* supported rates */
+	struct rtllib_info_element info_element[]; /* supported rates */
 } __packed;
 
 struct rtllib_txb {
@@ -859,7 +859,7 @@ struct rtllib_txb {
 	u16 reserved;
 	__le16 frag_size;
 	__le16 payload_size;
-	struct sk_buff *fragments[0];
+	struct sk_buff *fragments[];
 };
 
 #define MAX_SUBFRAME_COUNT		  64
@@ -1792,7 +1792,7 @@ struct rtllib_device {
 	/* This must be the last item so that it points to the data
 	 * allocated beyond this structure by alloc_rtllib
 	 */
-	u8 priv[0];
+	u8 priv[];
 };
 
 #define IEEE_A	    (1<<0)
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 9576b647f6b1..39f4ddd86796 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -886,14 +886,14 @@ enum ieee80211_mfie {
 struct rtl_80211_hdr {
 	__le16 frame_ctl;
 	__le16 duration_id;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtl_80211_hdr_1addr {
 	__le16 frame_ctl;
 	__le16 duration_id;
 	u8 addr1[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtl_80211_hdr_2addr {
@@ -901,7 +901,7 @@ struct rtl_80211_hdr_2addr {
 	__le16 duration_id;
 	u8 addr1[ETH_ALEN];
 	u8 addr2[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtl_80211_hdr_3addr {
@@ -911,7 +911,7 @@ struct rtl_80211_hdr_3addr {
 	u8 addr2[ETH_ALEN];
 	u8 addr3[ETH_ALEN];
 	__le16 seq_ctl;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtl_80211_hdr_4addr {
@@ -922,7 +922,7 @@ struct rtl_80211_hdr_4addr {
 	u8 addr3[ETH_ALEN];
 	__le16 seq_ctl;
 	u8 addr4[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct rtl_80211_hdr_3addrqos {
@@ -951,7 +951,7 @@ struct rtl_80211_hdr_4addrqos {
 struct ieee80211_info_element {
 	u8 id;
 	u8 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct ieee80211_authentication {
@@ -960,7 +960,7 @@ struct ieee80211_authentication {
 	__le16 transaction;
 	__le16 status;
 	/*challenge*/
-	struct ieee80211_info_element info_element[0];
+	struct ieee80211_info_element info_element[];
 } __packed;
 
 struct ieee80211_disassoc {
@@ -971,7 +971,7 @@ struct ieee80211_disassoc {
 struct ieee80211_probe_request {
 	struct rtl_80211_hdr_3addr header;
 	/* SSID, supported rates */
-	struct ieee80211_info_element info_element[0];
+	struct ieee80211_info_element info_element[];
 } __packed;
 
 struct ieee80211_probe_response {
@@ -982,7 +982,7 @@ struct ieee80211_probe_response {
 	/* SSID, supported rates, FH params, DS params,
 	 * CF params, IBSS params, TIM (if beacon), RSN
 	 */
-	struct ieee80211_info_element info_element[0];
+	struct ieee80211_info_element info_element[];
 } __packed;
 
 /* Alias beacon for probe_response */
@@ -993,7 +993,7 @@ struct ieee80211_assoc_request_frame {
 	__le16 capability;
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
-	struct ieee80211_info_element info_element[0];
+	struct ieee80211_info_element info_element[];
 } __packed;
 
 struct ieee80211_reassoc_request_frame {
@@ -1002,7 +1002,7 @@ struct ieee80211_reassoc_request_frame {
 	__le16 listen_interval;
 	u8 current_ap[ETH_ALEN];
 	/* SSID, supported rates, RSN */
-	struct ieee80211_info_element info_element[0];
+	struct ieee80211_info_element info_element[];
 } __packed;
 
 struct ieee80211_assoc_response_frame {
@@ -1010,7 +1010,7 @@ struct ieee80211_assoc_response_frame {
 	__le16 capability;
 	__le16 status;
 	__le16 aid;
-	struct ieee80211_info_element info_element[0]; /* supported rates */
+	struct ieee80211_info_element info_element[]; /* supported rates */
 } __packed;
 
 struct ieee80211_txb {
@@ -1021,7 +1021,7 @@ struct ieee80211_txb {
 	u16 reserved;
 	__le16 frag_size;
 	__le16 payload_size;
-	struct sk_buff *fragments[0];
+	struct sk_buff *fragments[];
 };
 
 #define MAX_TX_AGG_COUNT		  16
@@ -2007,7 +2007,7 @@ struct ieee80211_device {
 	/* This must be the last item so that it points to the data
 	 * allocated beyond this structure by alloc_ieee80211
 	 */
-	u8 priv[0];
+	u8 priv[];
 };
 
 #define IEEE_A            (1<<0)
diff --git a/drivers/staging/rtl8712/ieee80211.h b/drivers/staging/rtl8712/ieee80211.h
index 8098f6905554..dabaa8fd34fb 100644
--- a/drivers/staging/rtl8712/ieee80211.h
+++ b/drivers/staging/rtl8712/ieee80211.h
@@ -535,7 +535,7 @@ struct ieee80211_info_element_hdr {
 struct ieee80211_info_element {
 	u8 id;
 	u8 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /*
@@ -597,7 +597,7 @@ struct ieee80211_txb {
 	u16 reserved;
 	u16 frag_size;
 	u16 payload_size;
-	struct sk_buff *fragments[0];
+	struct sk_buff *fragments[];
 };
 
 /* SWEEP TABLE ENTRIES NUMBER*/
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
index 64e2ae436625..59fa6664d868 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
@@ -48,7 +48,7 @@ struct eeprom_rw_param {
 struct EFUSE_ACCESS_STRUCT {
 	u16	start_addr;
 	u16	cnts;
-	u8	data[0];
+	u8	data[];
 };
 
 struct burst_rw_reg {
@@ -324,7 +324,7 @@ struct mp_ioctl_handler {
 struct mp_ioctl_param {
 	unsigned int subcode;
 	unsigned int len;
-	unsigned char data[0];
+	unsigned char data[];
 };
 
 #define GEN_MP_IOCTL_SUBCODE(code) _MP_IOCTL_ ## code ## _CMD_
diff --git a/drivers/staging/wilc1000/cfg80211.c b/drivers/staging/wilc1000/cfg80211.c
index 995b1f306807..5d8faa01337d 100644
--- a/drivers/staging/wilc1000/cfg80211.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -62,7 +62,7 @@ struct wilc_p2p_pub_act_frame {
 	u8 oui_type;
 	u8 oui_subtype;
 	u8 dialog_token;
-	u8 elem[0];
+	u8 elem[];
 } __packed;
 
 struct wilc_vendor_specific_ie {
@@ -70,13 +70,13 @@ struct wilc_vendor_specific_ie {
 	u8 tag_len;
 	u8 oui[3];
 	u8 oui_type;
-	u8 attr[0];
+	u8 attr[];
 } __packed;
 
 struct wilc_attr_entry {
 	u8  attr_type;
 	__le16 attr_len;
-	u8 val[0];
+	u8 val[];
 } __packed;
 
 struct wilc_attr_oper_ch {
@@ -91,13 +91,13 @@ struct wilc_attr_ch_list {
 	u8 attr_type;
 	__le16 attr_len;
 	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
-	u8 elem[0];
+	u8 elem[];
 } __packed;
 
 struct wilc_ch_list_elem {
 	u8 op_class;
 	u8 no_of_channels;
-	u8 ch_list[0];
+	u8 ch_list[];
 } __packed;
 
 static void cfg_scan_result(enum scan_event scan_event,
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.c
index 44f7d48851b5..11653ac118cd 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -139,7 +139,7 @@ struct wilc_spi_read_rsp_data {
 	u8 status;
 	u8 resp_header;
 	u8 resp_data[4];
-	u8 crc[0];
+	u8 crc[];
 } __packed;
 
 struct wilc_spi_rsp_data {
diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index bdd7f414fdbb..88e894dd3568 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -355,7 +355,7 @@
 /* Commonly used basic types */
 struct hfa384x_bytestr {
 	__le16 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct hfa384x_bytestr32 {
@@ -421,7 +421,7 @@ struct hfa384x_authenticate_station_data {
 /*-- Configuration Record: WPAData       (data portion only) --*/
 struct hfa384x_wpa_data {
 	__le16 datalen;
-	u8 data[0];		/* max 80 */
+	u8 data[];		/* max 80 */
 } __packed;
 
 /*--------------------------------------------------------------------
diff --git a/drivers/staging/wlan-ng/p80211types.h b/drivers/staging/wlan-ng/p80211types.h
index ac254542fde6..3dcdd022da61 100644
--- a/drivers/staging/wlan-ng/p80211types.h
+++ b/drivers/staging/wlan-ng/p80211types.h
@@ -204,7 +204,7 @@ struct p80211pstr {
 
 struct p80211pstrd {
 	u8 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /* Maximum pascal string */
@@ -249,7 +249,7 @@ struct p80211itemd {
 	u32 did;
 	u16 status;
 	u16 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /* message data item for int, BOUNDEDINT, ENUMINT */
-- 
2.25.0

