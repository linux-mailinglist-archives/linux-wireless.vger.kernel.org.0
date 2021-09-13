Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF848409EC2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 23:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbhIMVEi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 17:04:38 -0400
Received: from mail-oln040093003008.outbound.protection.outlook.com ([40.93.3.8]:61941
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245321AbhIMVEg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 17:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiF2z6jKayLubvK+UioeWwDj6xN9TwBINbqQTnZjQZki+3ucenMQW5DdjV7dA5ku3QjsH8qpjS2IkYqbtb1ErAY72I7IiyZjHk4dm4McHFDqZcFLOp/3CTr3n8MUmLpWhJ0Rgvp4fwdFfEjyUsSK3dJz5/A+BtG/yf7tUq/u7ea87ihW2nJDNYkusNsgp48HOs456CB4WVR77DU1RdLUVqOOa0Or4Wpqe7DjwELqOqDDNTUL2o1tARxSHH3wi4wKf0rxjzRUmeN5vpczy0hSE7dkELOpXGk6yDq+usv2/dH17+avRYsxHp+GLjFSV8DL3v1bdEu9X2LS6Jjwz9hrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jhNLERPrgDFt8r8qoGRj0hXCSSiZho5rlHdlj4hJpHw=;
 b=iBVI5rutVuS4xDo9xIHMHtinZsaPO6HoVv5Zneuvs9vEGeNTe3eofT/ieCxkVV9WwnL0Y2OaMec1FvLZG/H0vypFQVy4JHWTrzntRToELmlPqR6S1agZRmBjiCT153mQay4R4DDW0bnYQMmCmtCPFi8Q3Me1Ai1LYatCdk93fmLQwqSIDCWnrHvQ9alIO95s9in5ag2xsXVNaPTgUmNJupi2A20nDFMK1A09cuYqrZUjqHnrvJlBDqKFj954twiHH726RTNMSuxkSF0Jkc6NCAP4M6XyciptRsVzG0bGxsR1ebqK8B5C302JXafQ0gTwWUthpeGaZ13fIiqq7mpgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhNLERPrgDFt8r8qoGRj0hXCSSiZho5rlHdlj4hJpHw=;
 b=RVIvvm8QsxXfTfnveH794mNmngxFjFwLUdQJe9vmZvviKUy7gScwe6ADybq069gpa64TbDRflG7Zru37uPMZhxGmcfVI2GRYH3Venlhz0gbCYmx5Ld+KnittIQJJr6PFi47o4zgkIccvMj2iYbKeTHGkP4hTzq8liBZTGEfou9c=
Received: from CY4PR21MB1540.namprd21.prod.outlook.com (2603:10b6:910:8a::20)
 by CY4PR21MB0696.namprd21.prod.outlook.com (2603:10b6:903:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.3; Mon, 13 Sep
 2021 21:03:16 +0000
Received: from CY4PR21MB1540.namprd21.prod.outlook.com
 ([fe80::d4e1:f4a2:b080:42d8]) by CY4PR21MB1540.namprd21.prod.outlook.com
 ([fe80::d4e1:f4a2:b080:42d8%5]) with mapi id 15.20.4523.011; Mon, 13 Sep 2021
 21:03:16 +0000
From:   Guillaume Hetier <Guillaume.Hetier@microsoft.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "schuffelen@google.com" <schuffelen@google.com>,
        Shwetha Bhat <shwbhat@microsoft.com>,
        Andrew Beltrano <anbeltra@microsoft.com>,
        Brian Perkins <Brian.Perkins@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: [RFC PATCH 1/1] Add control path virtualization in virt_wifi
Thread-Topic: [RFC PATCH 1/1] Add control path virtualization in virt_wifi
Thread-Index: Adeo4rOI8QazMW8KRJmQmRS8i5kvqw==
Date:   Mon, 13 Sep 2021 21:03:16 +0000
Message-ID: <CY4PR21MB15407FF4663D42C8CA3E1D678FD99@CY4PR21MB1540.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c633567a-df87-40be-8653-243043d405e6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-13T20:54:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4690a165-bce6-432c-2e82-08d976f9e821
x-ms-traffictypediagnostic: CY4PR21MB0696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0696B57E1A0A619CE97B7FD28FD99@CY4PR21MB0696.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPX9OkivpuzQm1kZz++/vyTnXbrwzTNgywXz02DMeEyDu0nI8MtEQyCQb2CAVISrn1wJNNSo//nz2QHUZIL9l5aeouXsk+esnZUIEBLc0z0FTbEf1RpjWTcPIDqPWtcr2UUIzjAD1GK5NSP++14nf1KV+BmgQZotIdogLPbR7aYtAS/QdT8pUB+xbxskOVKbPu+8dkx+a4YWiqRSeURpFYcFMpq1lo59iBl4adGY4idAEoepyOwckFVfM8OoA9AWU6DYi8Uy1DUXIqPKuFJH+ttJUO/IQ6h1O6UL/J01W4u5GC0ikw8bK7JEM2JiQZzikMG0E9/qMwYky9C8dTQhj7/wp3A+eG6/1Cwv7gUat9DdbZn1L+D+qxZtIjcG+Xx2R5MUKArJ2ptp7Jicql2M3ysXYMcQ2ab9casenr69vBbtn2xJTRpXMfm/V4vJdAzPMOyniMAt0iVpJY200BsVZv1wAmRyCKkWJJabVQgHhmLIk4vC0M6gcc+sIHWAYuuhbaLE4LhXVquDOJiE/kOChhRxAmBL5GuSCokYpLk/ly6yIw/7dib7OQ1JzzRF28tOpK4KP8jqUsKNuCOlNSVrsexfFR9BcSAVjNqSCDs/GAWscDktOtZSORVmTkbnGtSo+m3B+DROEs9hYj4ChbLr3yi09jbOc0JSuz3eumEULCgzJpRPIWi6RUmOydzzOu6Jq8naxR20dVIW3BfSj057+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1540.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(52536014)(6916009)(30864003)(54906003)(66574015)(4326008)(186003)(76116006)(55016002)(316002)(66556008)(83380400001)(8676002)(6506007)(107886003)(10290500003)(86362001)(9686003)(5660300002)(71200400001)(7696005)(64756008)(66946007)(66446008)(66476007)(2906002)(508600001)(8936002)(8990500004)(38100700002)(122000001)(82960400001)(33656002)(82950400001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RDdBCe8OW9cvIy2yCc3n1sdyJgWl/JsT1n7v1ysL6xGWXjMiNlcUtNpb7f0W?=
 =?us-ascii?Q?VVyYsdN5VCEtCQSdkdWIBJfR5tiiJ30JPXGfZSNvhgj8BuEDWFHBPvUaRFAP?=
 =?us-ascii?Q?EU6aq+rKmJ1Drd0WpitxGUb7Y34ssSgs1BPn4QMW79mSQH/OiUjuU+D1aXho?=
 =?us-ascii?Q?Zxpx/Gq9eYRcn3kXE1sdV7qdr2Kvt6rAX8g5qPHYR8nfH7knoJxGM24Hg/S+?=
 =?us-ascii?Q?9DGcLhkT4jiQ7dHvweE9hp3RRgev3m949diqmwv2u9oCP5EAnWKqiuLW2Bqm?=
 =?us-ascii?Q?+w1CgvW5WPA5NF8zagV7mQtGxZVAGfpsnq3bdgQRRPqNDer532XUpw9y8S8d?=
 =?us-ascii?Q?ybjmRKYlE6nHmXvx1PGBajNKI/WJfekCur+JrQS1a/6+l1vOEwktaisskRaO?=
 =?us-ascii?Q?jvsKAipymFeMwWimTGkvx5VZ3Hsq0o2krENJB83/gEiWRw8TUmGCBBuE0upl?=
 =?us-ascii?Q?IiqjbQLlJKqo+VBsnHvn3/NyeuhTopPolli55MOx5miKa20b9I50fkXOpRhW?=
 =?us-ascii?Q?92nk+j8zKrHb7YYV5sj4cgalDO53bwYhOhXk8fiZQD7WGRq0Zfv0/jnJgDC6?=
 =?us-ascii?Q?7mZH/JvK6IqmOTi7fYt4bCZIqQHGqebPBjtfxWi0j/2V9eUsiYfNjjHnMPTc?=
 =?us-ascii?Q?6bg1RlosBeJ2Y7HR/9yO3/mCPhZKzp6KNhvGcQhMlcfsrPy+3UgoamgL3xuG?=
 =?us-ascii?Q?ovPCqXFlfRoDO/lE7U7h1BWQNNw0HulMjQP7WGnbfw096ddGNOFWSq5R2CWU?=
 =?us-ascii?Q?XYKQZIC4UQYEzb2+nJsZH3EiDWbGjnMgMjVUG4YY/pppI7cOxWiKYxhvuNJA?=
 =?us-ascii?Q?KV6T1jLs7jddK97UP2aWsmEyTw5obFc9KMavHr/PvhmTmUyUWGNcc3HpY3WJ?=
 =?us-ascii?Q?4uYubDdNzLTy4IJ2hsGlTmsklsUzaPQhJi4vIb/mhxBMbS8t+oCqTyRy1vYL?=
 =?us-ascii?Q?UPZUY24gQaRGrdPhU0176EQQsHUPJLiAAHCKOEQSe0Tny42xEtNCDS0DSHb8?=
 =?us-ascii?Q?w/GKropfzXrEIo8S1DlaWJ2xtVrbyCfp6I1i4Hb6QvgF48OInRtJi/FaW1C+?=
 =?us-ascii?Q?Cdwsbx0wkMkjUfOwTrDc095KmzVySMBRFnToFhR7GG5809fvW8m+3q+ibBF8?=
 =?us-ascii?Q?aA898zMIhJBcd9aaaEepvjdNlSv+RpuL+eRLe0liT04c2S6aanT6swSxVZjX?=
 =?us-ascii?Q?qzENV08hVMC0pn3yVdM/DxaSa6YBXkqa8qwOcXJ2OMHWa7ruToqTYCTN/VJr?=
 =?us-ascii?Q?AQqf9JgS8BYyYjVX3xDBjQkPKvs7Mf9TBxd099Ezm8Fl3b0dV80g5H/anKqv?=
 =?us-ascii?Q?HBW2L5HXMtwhmwnCfr3xPz5CBSbGss//y/ywGDaAOXbK9ZFWZuAFZPlwj/1Z?=
 =?us-ascii?Q?LYVhMBo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1540.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4690a165-bce6-432c-2e82-08d976f9e821
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 21:03:16.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22igNkinPe2YN81UZAlCy1x5hP4rABPPvikZfMFl9SefgmKksIl9+aWF4NGuYCpTi45zTfiyw6VF3ZK445pu/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Today, there is no solution for Wi-Fi control path virtualization in a Linu=
x
virtual machine.  This patch is a proof of concept which adds support for a
virtualized control path in virt_wifi, by forwarding cfg80211 requests to a
host over VSOCK. We are seeking feedback regarding the packaging of this
feature, whether it should be part of virt_wifi, and the message format use=
d to
communicate with the host.

Existing drivers (mac80211_hwsim and virt_wifi) allow to simulate wlan netw=
orks
and to virtualize the data path. However they do not virtualize the control
path: a Linux guest cannot scan or connect to a real network.

Virtualizing the Wi-Fi control path would improve the fidelity of highly
integrated Linux virtual machines (such as Windows Subsystem for Linux) by
better reflecting the network state of the host. It could be of interest to
Linux based emulators (Android emulators). It also enables scenarios where
a connection to a specific Wi-Fi network is needed, such as configuring an =
IOT
device through Wi-Fi from a Linux guest.

This patch adds support for virtualized Wi-Fi operations to virt_wifi.
Virt_wifi already redirects the data path by binding on top of an interface
using rtnetlink. We add support for virtualized basic Wi-Fi station
operations by forwarding cfg80211 requests to a proxy running on the host. =
The
proxy can fulfill the requests and answer with the data expected by cfg8021=
1.

We are currently seeking feedback on two main points:

1) Where should this feature live?
2) What message format should be used for communications between the Linux =
guest
   and the host

For where the feature should live, we are considering two main options:=20

- Integrating our changes with virt_wifi.=20

  This is what we have done until now, since virt_wifi already handles the =
data
  path and implements the set of cfg80211 operations we want to virtualize:=
 we
  directly reuse most of the driver rtnetlink setup. We also believe we
  strictly extend the capability of virt_wifi, since the proxy can send
  simulated data to achieve the current behavior.  However, our handling of=
 the
  operations has significantly diverged from the original version, and back=
ward
  compatibility must be preserved (which is not done in this patch).  If we=
 go
  this way, the driver will have to keep a balance between its simulation a=
nd
  virtualization half, potentially leading to conflicts in the future.

- Creating a new Wi-Fi virtualization driver.

  We could contribute a new Wi-Fi driver, focused entirely on Wi-Fi
  virtualization. We believe it would be generic enough to be useful to the
  virtualization community at large, and it would have a clear goal instead=
 of
  keeping a balance between simulation and virtualization. This would also
  avoid any issue related to compatibility with the existing virt_wifi.
  However, this means adding a driver relatively similar to virt_wifi to th=
e
  kernel.

We are currently leaning toward the second option. We think having
virtualization as a clear, unique, goal and avoiding potential compatibilit=
y
issue is worth a new driver, especially considering the code could diverge
further.

For the message format, we have been using a custom binary format for
prototyping. However, this format will break compatibility every time a mes=
sage
needs to be extended or modified. We are considering several options:

- adding versioning to messages. This is easy to do, but the complexity wou=
ld
  increase with the number of versions support is needed for.

- using a more extensible format such as TLV. This would add some overhead =
to
  parse messages, but scale better with subsequent extensions, if we expect
  them to be somewhat frequent.

Are there existing recommendations or a standard way to solve this in the
kernel?

*NOTE*: This patch is still a work in progress to illustrate our propositio=
n,
but we would welcome any feedback or opinion about the overall design.

Suggested-By: Shwetha Bhat <shwbhat@microsoft.com>
Suggested-By: Brian Perkins <bperkins@microsoft.com>
Reviewed-By: Andrew Beltrano <anbeltra@microsoft.com>
Signed-off-by: Guillaume Hetier <guhetier@microsoft.com>
---
 drivers/net/wireless/Kconfig     |    1 +
 drivers/net/wireless/virt_wifi.c | 1138 +++++++++++++++++++++++++++---
 2 files changed, 1025 insertions(+), 114 deletions(-)

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 7add2002ff4c..ed63044eb9cd 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -107,6 +107,7 @@ config USB_NET_RNDIS_WLAN
 config VIRT_WIFI
 	tristate "Wifi wrapper for ethernet drivers"
 	depends on CFG80211
+	depends on VSOCKETS
 	help
 	  This option adds support for ethernet connections to appear as if they
 	  are wifi connections through a special rtnetlink device.
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_w=
ifi.c
index 514f2c1124b6..d40551080b01 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -15,19 +15,614 @@
 #include <linux/math64.h>
 #include <linux/module.h>
=20
+#include <linux/vm_sockets.h>
+#include <linux/net.h>
+#include <linux/skbuff.h>
+
+/* Ports must be in host byte order */
+#define HV_WIFI_REQUEST_PORT 12345
+#define HV_WIFI_NOTIFICATION_PORT 12346
+
+enum hv_wifi_operation {
+	WIFI_INVALID =3D 0,
+	WIFI_OP_SCAN_REQUEST =3D 1,
+	WIFI_OP_SCAN_RESPONSE,
+	WIFI_OP_CONNECT_REQUEST,
+	WIFI_OP_CONNECT_RESPONSE,
+	WIFI_OP_DISCONNECT_REQUEST,
+	WIFI_OP_DISCONNECT_RESPONSE,
+	WIFI_NOTIF_DISCONNECTED,
+	WIFI_NOTIF_SIGNAL_QUALITY,
+	WIFI_OP_MAX
+};
+
+struct hv_wifi_hdr {
+	/* An enum hv_wifi_operation value */
+	u8 operation;
+	u32 size;
+} __packed;
+
+struct hv_wifi_bss {
+	u8 bssid[ETH_ALEN];
+	u16 capabilities;
+	u32 rssi;
+	u16 beacon_interval;
+	u32 channel_center_freq;
+	u32 ie_size;
+	u32 ie_offset;
+} __packed;
+
+struct hv_wifi_scan_response {
+	u8 num_bss;
+	u32 total_size;
+	struct hv_wifi_bss bss[];
+} __packed;
+
+struct hv_wifi_connect_request {
+	u8 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 bssid[ETH_ALEN];
+	u8 auth_type;
+	u8 wpa_versions;
+	u8 num_akm_suites;
+	u32 akm_suites[NL80211_MAX_NR_AKM_SUITES];
+	u8 num_pairwise_cipher_suites;
+	u32 pairwise_cipher_suites[NL80211_MAX_NR_CIPHER_SUITES];
+	u8 group_cipher_suite;
+	u8 key_len;
+	u8 key[];
+} __packed;
+
+struct hv_wifi_connect_response {
+	u16 result_code;
+	u8 bssid[ETH_ALEN];
+	u32 session_id;
+} __packed;
+
+struct hv_wifi_disconnect_request {
+	u32 session_id;
+} __packed;
+
+struct hv_wifi_disconnect_notif {
+	u32 session_id;
+} __packed;
+
+struct hv_wifi_signal_quality_notif {
+	s8 signal;
+} __packed;
+
+struct hv_wifi_msg {
+	struct hv_wifi_hdr hdr;
+	u8 *body;
+};
+
+static int build_scan_request_msg(struct hv_wifi_msg *message)
+{
+	message->hdr.operation =3D WIFI_OP_SCAN_REQUEST;
+	message->hdr.size =3D 0;
+	return 0;
+}
+
+static int build_connect_request_message(struct hv_wifi_msg *message,
+					 const struct hv_wifi_connect_request *connection_params)
+{
+	message->hdr.operation =3D WIFI_OP_CONNECT_REQUEST;
+	message->hdr.size =3D sizeof(struct hv_wifi_connect_request) +
+			    connection_params->key_len;
+
+	message->body =3D kzalloc(message->hdr.size, GFP_KERNEL);
+	if (!message->body)
+		return -ENOMEM;
+
+	memcpy(message->body, connection_params, message->hdr.size);
+	return 0;
+}
+
+static int build_disconnect_request_message(struct hv_wifi_msg *message,
+					    u32 session_id)
+{
+	struct hv_wifi_disconnect_request *disconnect_request =3D NULL;
+
+	message->hdr.operation =3D WIFI_OP_DISCONNECT_REQUEST;
+	message->hdr.size =3D sizeof(struct hv_wifi_disconnect_request);
+
+	message->body =3D kzalloc(message->hdr.size, GFP_KERNEL);
+	if (!message->body)
+		return -ENOMEM;
+
+	disconnect_request =3D (struct hv_wifi_disconnect_request *)message->body=
;
+	disconnect_request->session_id =3D session_id;
+
+	return 0;
+}
+
+static int receive_bytes(struct socket *socket, size_t expected_size,
+			 u8 *buffer)
+{
+	int return_code =3D 0;
+	size_t total_received =3D 0;
+	struct msghdr msg_header =3D {0};
+	struct kvec iv =3D { .iov_len =3D expected_size, .iov_base =3D buffer };
+
+	while (total_received < expected_size) {
+		return_code =3D kernel_recvmsg(socket, &msg_header, &iv, 1,
+					     expected_size - total_received, 0);
+		if (return_code <=3D 0) {
+			printk(KERN_ERR "Failed to receive a message, error %d",
+			       return_code);
+			return return_code;
+		}
+
+		printk(KERN_DEBUG "Received %d bytes", return_code);
+		total_received +=3D return_code;
+		if (total_received > expected_size)
+			return -EINVAL;
+
+		iv.iov_len =3D expected_size - total_received;
+		iv.iov_base =3D (u8 *)buffer + total_received;
+		return_code =3D 0;
+	}
+
+	return 0;
+}
+
+static int receive_hv_wifi_message(struct socket *socket,
+				   struct hv_wifi_msg *message)
+{
+	int error =3D 0;
+
+	error =3D receive_bytes(socket, sizeof(message->hdr), (u8 *)&message->hdr=
);
+	if (error < 0)
+		return error;
+
+	printk(KERN_DEBUG "Receiving a message (Operation: %d, %d bytes)",
+	       message->hdr.operation, message->hdr.size);
+
+	kfree(message->body);
+	message->body =3D NULL;
+
+	if (message->hdr.size > 0) {
+		message->body =3D kzalloc(message->hdr.size, GFP_KERNEL);
+		if (!message->body)
+			return -ENOMEM;
+
+		error =3D receive_bytes(socket, message->hdr.size, message->body);
+		if (error < 0)
+			goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	kfree(message->body);
+	message->body =3D NULL;
+	return error;
+}
+
+static int send_bytes(struct socket *socket, size_t message_size, u8 *buff=
er)
+{
+	int return_code =3D 0;
+	size_t total_sent =3D 0;
+	struct msghdr msg_header =3D {0};
+	struct kvec iv =3D { .iov_len =3D message_size, .iov_base =3D buffer };
+
+	while (total_sent < message_size) {
+		return_code =3D kernel_sendmsg(socket, &msg_header, &iv, 1,
+					     message_size - total_sent);
+
+		if (return_code <=3D 0) {
+			printk(KERN_ERR "Failed to send a message, error %d",
+			       return_code);
+			return return_code;
+		}
+
+		printk(KERN_DEBUG "Sent %d bytes", return_code);
+		total_sent +=3D return_code;
+		if (total_sent > message_size)
+			return -EINVAL;
+
+		iv.iov_len =3D message_size - total_sent;
+		iv.iov_base =3D (u8 *)buffer + total_sent;
+		return_code =3D 0;
+	}
+
+	return 0;
+}
+
+static int send_hv_wifi_message(struct socket *socket,
+				struct hv_wifi_msg *message)
+{
+	int error =3D 0;
+
+	if (!message->body && message->hdr.size !=3D 0)
+		return -EINVAL;
+
+	printk(KERN_DEBUG "Sending a message (Operation: %d, %d bytes)",
+	       message->hdr.operation, message->hdr.size);
+
+	error =3D send_bytes(socket, sizeof(message->hdr), (u8 *)&message->hdr);
+	if (error < 0)
+		return error;
+
+	error =3D send_bytes(socket, message->hdr.size, message->body);
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static int query_host(struct hv_wifi_msg *message, unsigned int port)
+{
+	int error =3D 0;
+	struct socket *socket =3D NULL;
+	struct sockaddr_vm addr =3D {
+		.svm_family =3D AF_VSOCK,
+		.svm_port =3D port,
+		.svm_cid =3D VMADDR_CID_HOST,
+	};
+
+	error =3D sock_create_kern(&init_net, AF_VSOCK, SOCK_STREAM, 0, &socket);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to create a socket, error %d", error);
+		return error;
+	}
+
+	error =3D kernel_connect(socket, (struct sockaddr *)&addr,
+			       sizeof(addr), 0);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to connect to the host, error %d",
+		       error);
+		goto out_sock_release;
+	}
+
+	error =3D send_hv_wifi_message(socket, message);
+	if (error < 0) {
+		printk(KERN_ERR "Failed to send message, error %d", error);
+		goto out_sock_release;
+	} else {
+		printk(KERN_DEBUG "Sent message");
+	}
+
+	error =3D receive_hv_wifi_message(socket, message);
+	if (error < 0) {
+		printk(KERN_ERR "Failed to receive an answer, error %d", error);
+		goto out_sock_release;
+	} else {
+		printk(KERN_INFO "Received an answer");
+		error =3D 0;
+	}
+
+out_sock_release:
+	sock_release(socket);
+	return error;
+}
+
+static struct hv_wifi_msg scan_command(unsigned int port)
+{
+	int error =3D 0;
+	struct hv_wifi_msg message =3D {0};
+
+	printk(KERN_DEBUG "Sending SCAN request to host");
+
+	error =3D build_scan_request_msg(&message);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to build a scan request");
+		goto error;
+	}
+
+	error =3D query_host(&message, port);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Query host failed");
+		goto error;
+	}
+
+	return message;
+
+error:
+	kfree(message.body);
+	message.body =3D NULL;
+	message.hdr.size =3D 0;
+	message.hdr.operation =3D WIFI_INVALID;
+	return message;
+}
+
+static struct hv_wifi_msg connect_command(unsigned int port,
+					  const struct hv_wifi_connect_request *connection_params)
+{
+	int error =3D 0;
+	struct hv_wifi_msg message =3D {0};
+
+	printk(KERN_DEBUG "Sending CONNECT request to host");
+
+	error =3D build_connect_request_message(&message, connection_params);
+
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to build a connect request message");
+		goto error;
+	}
+
+	error =3D query_host(&message, port);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Query host failed");
+		goto error;
+	}
+
+	return message;
+
+error:
+	kfree(message.body);
+	message.body =3D NULL;
+	message.hdr.size =3D 0;
+	message.hdr.operation =3D WIFI_INVALID;
+	return message;
+}
+
+static struct hv_wifi_msg disconnect_command(unsigned int port, u32 sessio=
n_id)
+{
+	int error =3D 0;
+	struct hv_wifi_msg message =3D {0};
+
+	printk(KERN_DEBUG "Sending DISCONNECT request to host");
+
+	error =3D build_disconnect_request_message(&message, session_id);
+
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to build a connect request message");
+		goto error;
+	}
+
+	error =3D query_host(&message, port);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Query host failed");
+		goto error;
+	}
+
+	return message;
+
+error:
+	kfree(message.body);
+	message.body =3D NULL;
+	message.hdr.size =3D 0;
+	message.hdr.operation =3D WIFI_INVALID;
+	return message;
+}
+
+struct connection_state {
+	u32 tx_packets;
+	u32 tx_failed;
+	/* Protected by `virt_wifi_connection_lock` */
+	u8 bssid[ETH_ALEN];
+	/* Protected by `virt_wifi_connection_lock` */
+	bool is_connected;
+	/* Protected by `virt_wifi_connection_lock` */
+	s8 signal;
+	/* Protected by `virt_wifi_connection_lock` */
+	u32 session_id;
+};
+
+DEFINE_RWLOCK(virt_wifi_connection_lock);
+
+struct virt_wifi_netdev_priv {
+	struct work_struct connect;
+	struct work_struct disconnect;
+	struct net_device *lowerdev;
+	struct net_device *upperdev;
+	struct socket *notification_socket;
+	struct delayed_work notifications_work;
+	/* Protected by rtnl lock */
+	bool is_up;
+	/* Protected by rtnl lock */
+	bool being_deleted;
+	struct connection_state connection;
+	/* Not protected, but access are sequential */
+	struct hv_wifi_connect_request *connect_req_ctx;
+	unsigned int request_port;
+	unsigned int notification_port;
+};
+
+static void virt_wifi_disconnect_finalize(struct net_device *netdev,
+					  u16 reason_code);
+
+static void handle_disconnected_notification(struct virt_wifi_netdev_priv =
*priv,
+					     struct hv_wifi_msg message)
+{
+	struct hv_wifi_disconnect_notif *disconnect_notif =3D NULL;
+	u32 session_id =3D 0;
+
+	if (message.hdr.size !=3D sizeof(struct hv_wifi_disconnect_notif))
+		printk(KERN_WARNING "Unexpected size for a disconnect notification: %d b=
ytes\n",
+		       message.hdr.size);
+
+	disconnect_notif =3D (struct hv_wifi_disconnect_notif *)message.body;
+
+	read_lock(&virt_wifi_connection_lock);
+	session_id =3D priv->connection.session_id;
+	read_unlock(&virt_wifi_connection_lock);
+
+	if (disconnect_notif->session_id < session_id) {
+		printk(KERN_WARNING "Ignoring an outdated disconnection notification. "
+		       "Notification session: %d, current session: %d\n",
+		       disconnect_notif->session_id, session_id);
+		return;
+	}
+
+	virt_wifi_disconnect_finalize(priv->upperdev, WLAN_REASON_UNSPECIFIED);
+}
+
+static void handle_signal_quality_notification(
+	struct virt_wifi_netdev_priv *priv, struct hv_wifi_msg message)
+{
+	struct hv_wifi_signal_quality_notif *signal_notif =3D NULL;
+
+	if (message.hdr.size !=3D sizeof(struct hv_wifi_signal_quality_notif) ||
+	    !message.body) {
+		printk(KERN_ERR "Invalid size for a signal quality notification: %d byte=
s\n",
+		       message.hdr.size);
+		return;
+	}
+	signal_notif =3D (struct hv_wifi_signal_quality_notif *)message.body;
+
+	write_lock(&virt_wifi_connection_lock);
+	priv->connection.signal =3D signal_notif->signal;
+	write_unlock(&virt_wifi_connection_lock);
+}
+
+static void receive_notification(struct virt_wifi_netdev_priv *priv,
+				 struct socket *socket)
+{
+	int error =3D 0;
+	struct hv_wifi_msg message =3D {0};
+
+	error =3D receive_hv_wifi_message(socket, &message);
+	if (error < 0) {
+		printk(KERN_ERR "Failed to receive a notification, error %d\n",
+		       error);
+		goto out_free;
+	}
+
+	printk(KERN_DEBUG "Got a notification, type %d\n",
+	       message.hdr.operation);
+
+	// Dispatch the notification
+	if (message.hdr.operation =3D=3D WIFI_NOTIF_DISCONNECTED)
+		handle_disconnected_notification(priv, message);
+	else if (message.hdr.operation =3D=3D WIFI_NOTIF_SIGNAL_QUALITY)
+		handle_signal_quality_notification(priv, message);
+	else
+		printk(KERN_ERR "Received an unknown notification\n");
+
+out_free:
+	kfree(message.body);
+}
+
+static void poll_notifications(struct work_struct *work)
+{
+	int error =3D 0;
+	struct socket *connect_socket =3D NULL;
+	struct virt_wifi_netdev_priv *priv =3D container_of(work,
+		struct virt_wifi_netdev_priv, notifications_work.work);
+
+	for (;;) {
+		error =3D kernel_accept(priv->notification_socket,
+				      &connect_socket, SOCK_NONBLOCK);
+		if (error =3D=3D -EWOULDBLOCK) {
+			// We are done processing incoming notifications
+			break;
+		} else if (error !=3D 0) {
+			printk(KERN_ERR "Failed to accept a connection, error %d",
+			       error);
+			break;
+		}
+
+		receive_notification(priv, connect_socket);
+
+		kernel_sock_shutdown(connect_socket, SHUT_RDWR);
+		sock_release(connect_socket);
+		connect_socket =3D NULL;
+	}
+
+	// Re-arm the notification work
+	// schedule_delayed_work(&priv->notifications_work, 2 * HZ);
+	queue_delayed_work(system_long_wq, &priv->notifications_work, 2 * HZ);
+}
+
+static int setup_notification_channel(struct virt_wifi_netdev_priv *netdev=
_priv,
+				      unsigned int port)
+{
+	int error =3D 0;
+	struct sockaddr_vm addr =3D {
+		.svm_family =3D AF_VSOCK,
+		.svm_port =3D port,
+		.svm_cid =3D VMADDR_CID_ANY
+	};
+
+	error =3D sock_create_kern(&init_net, AF_VSOCK, SOCK_STREAM, 0,
+				 &netdev_priv->notification_socket);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to create a socket, error %d", error);
+		return error;
+	}
+
+	error =3D kernel_bind(netdev_priv->notification_socket,
+			    (struct sockaddr *)&addr, sizeof(addr));
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to bind a socket, error %d", error);
+		goto out_release_sock;
+	}
+
+	error =3D kernel_listen(netdev_priv->notification_socket, INT_MAX);
+	if (error !=3D 0) {
+		printk(KERN_ERR "Failed to listen on a socket, error %d",
+		       error);
+		goto out_release_sock;
+	}
+
+	// Start the notification handling thread
+	INIT_DELAYED_WORK(&netdev_priv->notifications_work, poll_notifications);
+	if (!schedule_delayed_work(&netdev_priv->notifications_work, 2 * HZ)) {
+		printk(KERN_ERR "Failed to start the notification work");
+		error =3D -EINVAL;
+		goto out_release_sock;
+	}
+
+	return 0;
+
+out_release_sock:
+	sock_release(netdev_priv->notification_socket);
+	return error;
+}
+
+static void stop_notification_channel(struct virt_wifi_netdev_priv *netdev=
_priv)
+{
+	printk(KERN_DEBUG "Waiting for notification work completion...");
+	cancel_delayed_work_sync(&netdev_priv->notifications_work);
+
+	sock_release(netdev_priv->notification_socket);
+	netdev_priv->notification_socket =3D NULL;
+}
+
 static struct wiphy *common_wiphy;
=20
 struct virt_wifi_wiphy_priv {
-	struct delayed_work scan_result;
+	struct work_struct scan_result;
+	/* Not protected but access are sequentials */
 	struct cfg80211_scan_request *scan_request;
+	/* Protected by rtnl lock */
 	bool being_deleted;
 };
=20
-static struct ieee80211_channel channel_2ghz =3D {
-	.band =3D NL80211_BAND_2GHZ,
-	.center_freq =3D 2432,
-	.hw_value =3D 2432,
-	.max_power =3D 20,
+u32 cipher_suites[] =3D {
+	WLAN_CIPHER_SUITE_CCMP,
+	WLAN_CIPHER_SUITE_GCMP,
+	WLAN_CIPHER_SUITE_CCMP_256,
+	WLAN_CIPHER_SUITE_GCMP_256,
+	WLAN_CIPHER_SUITE_AES_CMAC,
+	WLAN_CIPHER_SUITE_BIP_GMAC_128,
+	WLAN_CIPHER_SUITE_BIP_CMAC_256,
+	WLAN_CIPHER_SUITE_BIP_GMAC_256
+};
+
+u32 akm_suites[] =3D {
+	WLAN_AKM_SUITE_PSK,
+	WLAN_AKM_SUITE_SAE
+};
+
+static struct ieee80211_channel channels_2ghz[] =3D {
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2412, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2417, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2422, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2427, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2432, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2437, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2442, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2447, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2452, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2457, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2462, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2467, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2472, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2477, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_2GHZ, .center_freq =3D 2484, .max_power =3D 20, =
},
 };
=20
 static struct ieee80211_rate bitrates_2ghz[] =3D {
@@ -41,10 +636,10 @@ static struct ieee80211_rate bitrates_2ghz[] =3D {
 };
=20
 static struct ieee80211_supported_band band_2ghz =3D {
-	.channels =3D &channel_2ghz,
+	.channels =3D channels_2ghz,
 	.bitrates =3D bitrates_2ghz,
 	.band =3D NL80211_BAND_2GHZ,
-	.n_channels =3D 1,
+	.n_channels =3D ARRAY_SIZE(channels_2ghz),
 	.n_bitrates =3D ARRAY_SIZE(bitrates_2ghz),
 	.ht_cap =3D {
 		.ht_supported =3D true,
@@ -62,11 +657,63 @@ static struct ieee80211_supported_band band_2ghz =3D {
 	},
 };
=20
-static struct ieee80211_channel channel_5ghz =3D {
-	.band =3D NL80211_BAND_5GHZ,
-	.center_freq =3D 5240,
-	.hw_value =3D 5240,
-	.max_power =3D 20,
+static struct ieee80211_channel channels_5ghz[] =3D {
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5160, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5170, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5180, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5190, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5200, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5210, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5220, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5230, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5240, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5250, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5260, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5270, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5280, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5290, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5300, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5310, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5320, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5340, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5480, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5500, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5510, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5520, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5530, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5540, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5550, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5560, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5570, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5580, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5590, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5600, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5610, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5620, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5630, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5640, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5660, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5670, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5680, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5690, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5700, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5710, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5720, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5745, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5755, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5765, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5775, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5785, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5795, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5805, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5815, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5825, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5835, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5845, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5855, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5865, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5875, .max_power =3D 20, =
},
+	{ .band =3D NL80211_BAND_5GHZ, .center_freq =3D 5885, .max_power =3D 20, =
},
 };
=20
 static struct ieee80211_rate bitrates_5ghz[] =3D {
@@ -94,10 +741,10 @@ static struct ieee80211_rate bitrates_5ghz[] =3D {
 		    IEEE80211_VHT_MCS_SUPPORT_0_9 << 14)
=20
 static struct ieee80211_supported_band band_5ghz =3D {
-	.channels =3D &channel_5ghz,
+	.channels =3D channels_5ghz,
 	.bitrates =3D bitrates_5ghz,
 	.band =3D NL80211_BAND_5GHZ,
-	.n_channels =3D 1,
+	.n_channels =3D ARRAY_SIZE(channels_5ghz),
 	.n_bitrates =3D ARRAY_SIZE(bitrates_5ghz),
 	.ht_cap =3D {
 		.ht_supported =3D true,
@@ -133,32 +780,6 @@ static struct ieee80211_supported_band band_5ghz =3D {
 	},
 };
=20
-/* Assigned at module init. Guaranteed locally-administered and unicast. *=
/
-static u8 fake_router_bssid[ETH_ALEN] __ro_after_init =3D {};
-
-static void virt_wifi_inform_bss(struct wiphy *wiphy)
-{
-	u64 tsf =3D div_u64(ktime_get_boottime_ns(), 1000);
-	struct cfg80211_bss *informed_bss;
-	static const struct {
-		u8 tag;
-		u8 len;
-		u8 ssid[8];
-	} __packed ssid =3D {
-		.tag =3D WLAN_EID_SSID,
-		.len =3D 8,
-		.ssid =3D "VirtWifi",
-	};
-
-	informed_bss =3D cfg80211_inform_bss(wiphy, &channel_5ghz,
-					   CFG80211_BSS_FTYPE_PRESP,
-					   fake_router_bssid, tsf,
-					   WLAN_CAPABILITY_ESS, 0,
-					   (void *)&ssid, sizeof(ssid),
-					   DBM_TO_MBM(-50), GFP_KERNEL);
-	cfg80211_put_bss(wiphy, informed_bss);
-}
-
 /* Called with the rtnl lock held. */
 static int virt_wifi_scan(struct wiphy *wiphy,
 			  struct cfg80211_scan_request *request)
@@ -171,25 +792,88 @@ static int virt_wifi_scan(struct wiphy *wiphy,
 		return -EBUSY;
=20
 	priv->scan_request =3D request;
-	schedule_delayed_work(&priv->scan_result, HZ * 2);
+	if (!queue_work(system_long_wq, &priv->scan_result))
+		return -EBUSY;
=20
 	return 0;
 }
=20
+static int report_scanned_network(struct wiphy *wiphy, struct hv_wifi_bss =
*bss)
+{
+	struct cfg80211_bss *informed_bss =3D NULL;
+	const u64 tsf =3D div_u64(ktime_get_boottime_ns(), 1000);
+	struct ieee80211_channel *channel =3D NULL;
+
+	channel =3D ieee80211_get_channel_khz(wiphy, bss->channel_center_freq);
+	if (!channel) {
+		printk(KERN_ERR "Unsupported frequency: %d, ignoring scan result\n",
+		       bss->channel_center_freq);
+		return -EINVAL;
+	}
+
+	informed_bss =3D cfg80211_inform_bss(wiphy, channel,
+		CFG80211_BSS_FTYPE_PRESP, bss->bssid, tsf, bss->capabilities,
+		bss->beacon_interval, (u8 *)bss + bss->ie_offset, bss->ie_size,
+		bss->rssi * 100, /* rssi expected in mBm */
+		GFP_KERNEL);
+
+	cfg80211_put_bss(wiphy, informed_bss);
+	return 0;
+}
+
+static bool is_bss_valid(const struct hv_wifi_bss *bss,
+			 const struct hv_wifi_msg *message)
+{
+	// Check the bss and its IEs are contained in the message body
+	return (u8 *)bss >=3D message->body &&
+	       (u8 *)bss + bss->ie_offset + bss->ie_size <=3D
+			(u8 *)message->body + message->hdr.size;
+}
+
 /* Acquires and releases the rdev BSS lock. */
 static void virt_wifi_scan_result(struct work_struct *work)
 {
-	struct virt_wifi_wiphy_priv *priv =3D
-		container_of(work, struct virt_wifi_wiphy_priv,
-			     scan_result.work);
-	struct wiphy *wiphy =3D priv_to_wiphy(priv);
+	struct virt_wifi_wiphy_priv *w_priv =3D
+		container_of(work, struct virt_wifi_wiphy_priv, scan_result);
+	struct wiphy *wiphy =3D priv_to_wiphy(w_priv);
+	struct virt_wifi_netdev_priv *n_priv =3D
+				netdev_priv(w_priv->scan_request->wdev->netdev);
 	struct cfg80211_scan_info scan_info =3D { .aborted =3D false };
+	struct hv_wifi_msg message =3D {0};
+	struct hv_wifi_scan_response *scan_response =3D NULL;
+	struct hv_wifi_bss *bss =3D NULL;
+	int i =3D 0;
+
+	message =3D scan_command(n_priv->request_port);
+	if (message.hdr.operation !=3D WIFI_OP_SCAN_RESPONSE) {
+		printk(KERN_DEBUG "%s: no scan response (%d)\n", __func__,
+		       message.hdr.operation);
+		goto complete_scan;
+	}
=20
-	virt_wifi_inform_bss(wiphy);
+	scan_response =3D (struct hv_wifi_scan_response *)message.body;
+
+	printk(KERN_DEBUG "%s: number of scan results: %u\n", __func__,
+	       scan_response->num_bss);
+
+	for (i =3D 0; i < scan_response->num_bss; i++) {
+		bss =3D &scan_response->bss[i];
+		if (!is_bss_valid(bss, &message)) {
+			printk(KERN_ERR "Ignoring an invalid scan result");
+			printk(KERN_DEBUG "Invalid scan result: Index <%d>, IEs offset <%d>, IE=
s size <%d>",
+			       i, bss->ie_offset, bss->ie_size);
+			continue;
+		}
+
+		report_scanned_network(wiphy, &scan_response->bss[i]);
+	}
+
+complete_scan:
=20
 	/* Schedules work which acquires and releases the rtnl lock. */
-	cfg80211_scan_done(priv->scan_request, &scan_info);
-	priv->scan_request =3D NULL;
+	cfg80211_scan_done(w_priv->scan_request, &scan_info);
+	w_priv->scan_request =3D NULL;
+	kfree(message.body);
 }
=20
 /* May acquire and release the rdev BSS lock. */
@@ -197,7 +881,7 @@ static void virt_wifi_cancel_scan(struct wiphy *wiphy)
 {
 	struct virt_wifi_wiphy_priv *priv =3D wiphy_priv(wiphy);
=20
-	cancel_delayed_work_sync(&priv->scan_result);
+	cancel_work_sync(&priv->scan_result);
 	/* Clean up dangling callbacks if necessary. */
 	if (priv->scan_request) {
 		struct cfg80211_scan_info scan_info =3D { .aborted =3D true };
@@ -207,88 +891,230 @@ static void virt_wifi_cancel_scan(struct wiphy *wiph=
y)
 	}
 }
=20
-struct virt_wifi_netdev_priv {
-	struct delayed_work connect;
-	struct net_device *lowerdev;
-	struct net_device *upperdev;
-	u32 tx_packets;
-	u32 tx_failed;
-	u8 connect_requested_bss[ETH_ALEN];
-	bool is_up;
-	bool is_connected;
-	bool being_deleted;
-};
+static int build_connect_request_context(struct cfg80211_connect_params *s=
me,
+					 struct hv_wifi_connect_request **connect_req_ctx)
+{
+	struct hv_wifi_connect_request *context =3D NULL;
+	u8 key_len =3D 0;
+	const u8 *key =3D NULL;
+
+	/* Determine which key to use and its length */
+	if (sme->crypto.psk) {
+		printk(KERN_DEBUG "PSK present in connnect request");
+		key =3D sme->crypto.psk;
+		key_len =3D WLAN_PMK_LEN;
+	} else if (sme->crypto.sae_pwd && sme->crypto.sae_pwd_len) {
+		printk(KERN_DEBUG "SAE password present in connnect request");
+		key =3D sme->crypto.sae_pwd;
+		key_len =3D sme->crypto.sae_pwd_len;
+	} else if (sme->key && sme->key_len > 0) {
+		printk(KERN_DEBUG "WEP present in connnect request");
+		key =3D sme->key;
+		key_len =3D sme->key_len;
+	} else {
+		printk(KERN_DEBUG "No key provided in connect request");
+	}
+
+	context =3D kzalloc(sizeof(*context) + key_len, GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+
+	/* Get SSID */
+	memcpy(context->ssid, sme->ssid, sme->ssid_len);
+	context->ssid_len =3D sme->ssid_len;
+
+	/* Get requested BSS if any */
+	if (sme->bssid)
+		/* Can't use ether_addr_copy: dest bssid not aligned to u16 */
+		memcpy(context->bssid, sme->bssid, ETH_ALEN);
+	else
+		eth_zero_addr(context->bssid);
+
+	/* Get security params */
+	context->auth_type =3D sme->auth_type;
+	context->wpa_versions =3D (u8)sme->crypto.wpa_versions;
+
+	context->num_akm_suites =3D sme->crypto.n_akm_suites;
+	memcpy(context->akm_suites, sme->crypto.akm_suites,
+	       sme->crypto.n_akm_suites * sizeof(sme->crypto.akm_suites[0]));
+
+	context->num_pairwise_cipher_suites =3D sme->crypto.n_ciphers_pairwise;
+	memcpy(context->pairwise_cipher_suites, sme->crypto.ciphers_pairwise,
+	       sme->crypto.n_ciphers_pairwise * sizeof(sme->crypto.ciphers_pairwi=
se[0]));
+
+	context->group_cipher_suite =3D sme->crypto.cipher_group;
+	context->key_len =3D key_len;
+	memcpy(context->key, key, key_len);
+
+	*connect_req_ctx =3D context;
+	return 0;
+}
=20
 /* Called with the rtnl lock held. */
+/* Acquires and releases virt_wifi_connection_lock. */
 static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netde=
v,
 			     struct cfg80211_connect_params *sme)
 {
+	int error =3D 0;
 	struct virt_wifi_netdev_priv *priv =3D netdev_priv(netdev);
-	bool could_schedule;
+
+	wiphy_debug(wiphy, "connect\n");
=20
 	if (priv->being_deleted || !priv->is_up)
 		return -EBUSY;
=20
-	could_schedule =3D schedule_delayed_work(&priv->connect, HZ * 2);
-	if (!could_schedule)
-		return -EBUSY;
+	kfree(priv->connect_req_ctx);
+	priv->connect_req_ctx =3D NULL;
+	error =3D build_connect_request_context(sme, &priv->connect_req_ctx);
+	if (error < 0)
+		return error;
=20
-	if (sme->bssid) {
-		ether_addr_copy(priv->connect_requested_bss, sme->bssid);
-	} else {
-		virt_wifi_inform_bss(wiphy);
-		eth_zero_addr(priv->connect_requested_bss);
-	}
+	/* Set the bssid for the canceling the connection if needed */
+	write_lock(&virt_wifi_connection_lock);
+	if (sme->bssid)
+		ether_addr_copy(priv->connection.bssid, sme->bssid);
+	else
+		eth_zero_addr(priv->connection.bssid);
+	write_unlock(&virt_wifi_connection_lock);
=20
-	wiphy_debug(wiphy, "connect\n");
+	if (!queue_work(system_long_wq, &priv->connect))
+		return -EBUSY;
=20
 	return 0;
 }
=20
 /* Acquires and releases the rdev event lock. */
+/* Acquires and releases virt_wifi_connection_lock. */
 static void virt_wifi_connect_complete(struct work_struct *work)
 {
 	struct virt_wifi_netdev_priv *priv =3D
-		container_of(work, struct virt_wifi_netdev_priv, connect.work);
-	u8 *requested_bss =3D priv->connect_requested_bss;
-	bool right_addr =3D ether_addr_equal(requested_bss, fake_router_bssid);
-	u16 status =3D WLAN_STATUS_SUCCESS;
+		container_of(work, struct virt_wifi_netdev_priv, connect);
+	u16 status =3D WLAN_STATUS_UNSPECIFIED_FAILURE;
+	struct hv_wifi_connect_response *connect_response =3D NULL;
+	struct hv_wifi_msg message =3D {0};
+	u8 connected_bssid[ETH_ALEN];
+
+	if (!priv->connect_req_ctx) {
+		printk(KERN_ERR "%s: No connection parameters when completing a connecti=
on request\n",
+		       __func__);
+		return;
+	}
=20
-	if (is_zero_ether_addr(requested_bss))
-		requested_bss =3D NULL;
+	message =3D connect_command(priv->request_port, priv->connect_req_ctx);
=20
-	if (!priv->is_up || (requested_bss && !right_addr))
-		status =3D WLAN_STATUS_UNSPECIFIED_FAILURE;
-	else
-		priv->is_connected =3D true;
+	if (message.hdr.operation !=3D WIFI_OP_CONNECT_RESPONSE) {
+		printk(KERN_ERR "%s: No connect response (%d)\n",
+		       __func__, message.hdr.operation);
+		goto complete_connect;
+	}
+
+	if (!priv->is_up)
+		goto complete_connect;
+
+	connect_response =3D (struct hv_wifi_connect_response *)message.body;
+	status =3D connect_response->result_code;
+
+	if (status =3D=3D WLAN_STATUS_SUCCESS) {
+		/* Set the current connection information */
+		write_lock(&virt_wifi_connection_lock);
+		priv->connection.is_connected =3D true;
+		/* Can't use ether_addr_copy: dest bssid not aligned to u16 */
+		memcpy(priv->connection.bssid, connect_response->bssid,
+		       sizeof(priv->connection.bssid));
+		priv->connection.signal =3D -50;
+		priv->connection.session_id =3D connect_response->session_id;
+		write_unlock(&virt_wifi_connection_lock);
+
+		priv->connection.tx_failed =3D 0;
+		priv->connection.tx_packets =3D 0;
+
+		netif_carrier_on(priv->upperdev);
+	}
+
+complete_connect:
+	write_lock(&virt_wifi_connection_lock);
+	ether_addr_copy(connected_bssid, priv->connection.bssid);
+	write_unlock(&virt_wifi_connection_lock);
=20
 	/* Schedules an event that acquires the rtnl lock. */
-	cfg80211_connect_result(priv->upperdev, requested_bss, NULL, 0, NULL, 0,
-				status, GFP_KERNEL);
-	netif_carrier_on(priv->upperdev);
+	cfg80211_connect_result(priv->upperdev, connected_bssid, NULL, 0, NULL,
+				0, status, GFP_KERNEL);
+
+	kfree(priv->connect_req_ctx);
+	priv->connect_req_ctx =3D NULL;
+
+	kfree(message.body);
 }
=20
 /* May acquire and release the rdev event lock. */
+/* May acquire and release virt_wifi_connection_lock */
 static void virt_wifi_cancel_connect(struct net_device *netdev)
 {
+	u8 bssid[ETH_ALEN] =3D {0};
 	struct virt_wifi_netdev_priv *priv =3D netdev_priv(netdev);
=20
 	/* If there is work pending, clean up dangling callbacks. */
-	if (cancel_delayed_work_sync(&priv->connect)) {
+	if (cancel_work_sync(&priv->connect)) {
+		read_lock(&virt_wifi_connection_lock);
+		ether_addr_copy(bssid, priv->connection.bssid);
+		read_unlock(&virt_wifi_connection_lock);
+
 		/* Schedules an event that acquires the rtnl lock. */
-		cfg80211_connect_result(priv->upperdev,
-					priv->connect_requested_bss, NULL, 0,
-					NULL, 0,
+		cfg80211_connect_result(priv->upperdev, bssid, NULL, 0, NULL, 0,
 					WLAN_STATUS_UNSPECIFIED_FAILURE,
 					GFP_KERNEL);
 	}
 }
=20
-/* Called with the rtnl lock held. Acquires the rdev event lock. */
+/* Subcall acquires the rdev event lock. */
+/* Acquires and releases virt_wifi_connection_lock */
+static void virt_wifi_disconnect_finalize(struct net_device *netdev,
+					  u16 reason_code)
+{
+	struct virt_wifi_netdev_priv *priv =3D netdev_priv(netdev);
+
+	cfg80211_disconnected(netdev, reason_code, NULL, 0, true, GFP_KERNEL);
+
+	write_lock(&virt_wifi_connection_lock);
+	priv->connection.is_connected =3D false;
+	write_unlock(&virt_wifi_connection_lock);
+
+	netif_carrier_off(netdev);
+}
+
+/* Subcall acquires the rdev event lock. */
+/* Subcall acquires and releases virt_wifi_connection_lock */
+static void virt_wifi_disconnect_complete(struct work_struct *work)
+{
+	struct virt_wifi_netdev_priv *priv =3D
+		container_of(work, struct virt_wifi_netdev_priv, disconnect);
+	struct hv_wifi_msg message =3D {0};
+	u32 session_id =3D 0;
+
+	read_lock(&virt_wifi_connection_lock);
+	session_id =3D priv->connection.session_id;
+	read_unlock(&virt_wifi_connection_lock);
+
+	message =3D disconnect_command(priv->request_port, session_id);
+
+	/* Still complete the disconnection on error */
+	if (message.hdr.operation !=3D WIFI_OP_DISCONNECT_RESPONSE)
+		printk(KERN_ERR "Expected WIFI_OP_DISCONNECT_RESPONSE, got: %d",
+		       message.hdr.operation);
+
+	virt_wifi_disconnect_finalize(priv->upperdev, WLAN_REASON_UNSPECIFIED);
+
+	kfree(message.body);
+}
+
+/* Called with the rtnl lock held. */
+/* Subcall acquires and releases the rdev event lock. */
+/* Subcall acquires and releases virt_wifi_connection_lock. */
 static int virt_wifi_disconnect(struct wiphy *wiphy, struct net_device *ne=
tdev,
 				u16 reason_code)
 {
 	struct virt_wifi_netdev_priv *priv =3D netdev_priv(netdev);
+	bool is_connected =3D false;
=20
 	if (priv->being_deleted)
 		return -EBUSY;
@@ -296,51 +1122,78 @@ static int virt_wifi_disconnect(struct wiphy *wiphy,=
 struct net_device *netdev,
 	wiphy_debug(wiphy, "disconnect\n");
 	virt_wifi_cancel_connect(netdev);
=20
-	cfg80211_disconnected(netdev, reason_code, NULL, 0, true, GFP_KERNEL);
-	priv->is_connected =3D false;
-	netif_carrier_off(netdev);
+	read_lock(&virt_wifi_connection_lock);
+	is_connected =3D priv->connection.is_connected;
+	read_unlock(&virt_wifi_connection_lock);
+
+	if (!is_connected) {
+		virt_wifi_disconnect_finalize(netdev, reason_code);
+	} else {
+		if (!queue_work(system_long_wq, &priv->disconnect))
+			return -EBUSY;
+	}
=20
 	return 0;
 }
=20
 /* Called with the rtnl lock held. */
+/* Acquires and releases virt_wifi_connection_lock. */
 static int virt_wifi_get_station(struct wiphy *wiphy, struct net_device *d=
ev,
 				 const u8 *mac, struct station_info *sinfo)
 {
+	int error =3D 0;
 	struct virt_wifi_netdev_priv *priv =3D netdev_priv(dev);
=20
 	wiphy_debug(wiphy, "get_station\n");
=20
-	if (!priv->is_connected || !ether_addr_equal(mac, fake_router_bssid))
-		return -ENOENT;
+	read_lock(&virt_wifi_connection_lock);
+
+	if (!priv->connection.is_connected) {
+		error =3D -ENOENT;
+		goto out_unlock;
+	}
+
+	if (!ether_addr_equal(mac, priv->connection.bssid)) {
+		error =3D -ENOENT;
+		goto out_unlock;
+	}
=20
 	sinfo->filled =3D BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
 		BIT_ULL(NL80211_STA_INFO_TX_FAILED) |
 		BIT_ULL(NL80211_STA_INFO_SIGNAL) |
 		BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-	sinfo->tx_packets =3D priv->tx_packets;
-	sinfo->tx_failed =3D priv->tx_failed;
+	sinfo->tx_packets =3D priv->connection.tx_packets;
+	sinfo->tx_failed =3D priv->connection.tx_failed;
 	/* For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_ */
-	sinfo->signal =3D -50;
+	sinfo->signal =3D priv->connection.signal;
 	sinfo->txrate =3D (struct rate_info) {
 		.legacy =3D 10, /* units are 100kbit/s */
 	};
-	return 0;
+
+out_unlock:
+	read_unlock(&virt_wifi_connection_lock);
+	return error;
 }
=20
 /* Called with the rtnl lock held. */
+/* Acquires and releases virt_wifi_connection_lock. */
 static int virt_wifi_dump_station(struct wiphy *wiphy, struct net_device *=
dev,
 				  int idx, u8 *mac, struct station_info *sinfo)
 {
 	struct virt_wifi_netdev_priv *priv =3D netdev_priv(dev);
+	bool is_connected =3D false;
=20
 	wiphy_debug(wiphy, "dump_station\n");
=20
-	if (idx !=3D 0 || !priv->is_connected)
+	read_lock(&virt_wifi_connection_lock);
+	is_connected =3D priv->connection.is_connected;
+	ether_addr_copy(mac, priv->connection.bssid);
+	read_unlock(&virt_wifi_connection_lock);
+
+	if (idx !=3D 0 || !is_connected)
 		return -ENOENT;
=20
-	ether_addr_copy(mac, fake_router_bssid);
-	return virt_wifi_get_station(wiphy, dev, fake_router_bssid, sinfo);
+	return virt_wifi_get_station(wiphy, dev, mac, sinfo);
 }
=20
 static const struct cfg80211_ops virt_wifi_cfg80211_ops =3D {
@@ -375,10 +1228,23 @@ static struct wiphy *virt_wifi_make_wiphy(void)
=20
 	wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION);
=20
+	// Set security capabilities
+	wiphy->akm_suites =3D akm_suites;
+	wiphy->n_akm_suites =3D ARRAY_SIZE(akm_suites);
+	wiphy->cipher_suites =3D cipher_suites;
+	wiphy->n_cipher_suites =3D ARRAY_SIZE(cipher_suites);
+
+	// Offload handshakes (the host take care of it)
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK);
+
+	// TODO guhetier: Enable or remove depending on if we can get SAE offload
+	// wiphy->features |=3D NL80211_FEATURE_SAE;
+	// wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SAE_OFFLOAD);
+
 	priv =3D wiphy_priv(wiphy);
 	priv->being_deleted =3D false;
 	priv->scan_request =3D NULL;
-	INIT_DELAYED_WORK(&priv->scan_result, virt_wifi_scan_result);
+	INIT_WORK(&priv->scan_result, virt_wifi_scan_result);
=20
 	err =3D wiphy_register(wiphy);
 	if (err < 0) {
@@ -408,16 +1274,23 @@ static void virt_wifi_destroy_wiphy(struct wiphy *wi=
phy)
 }
=20
 /* Enters and exits a RCU-bh critical section. */
+/* Aquires and releases virt_wifi_connection_lock. */
 static netdev_tx_t virt_wifi_start_xmit(struct sk_buff *skb,
 					struct net_device *dev)
 {
+	bool is_connected =3D false;
 	struct virt_wifi_netdev_priv *priv =3D netdev_priv(dev);
=20
-	priv->tx_packets++;
-	if (!priv->is_connected) {
-		priv->tx_failed++;
+	read_lock(&virt_wifi_connection_lock);
+	is_connected =3D priv->connection.is_connected;
+	read_unlock(&virt_wifi_connection_lock);
+
+	priv->connection.tx_packets++;
+	if (!is_connected)
+		priv->connection.tx_failed++;
+
+	if (!is_connected)
 		return NET_XMIT_DROP;
-	}
=20
 	skb->dev =3D priv->lowerdev;
 	return dev_queue_xmit(skb);
@@ -478,17 +1351,23 @@ static void virt_wifi_setup(struct net_device *dev)
 {
 	ether_setup(dev);
 	dev->netdev_ops =3D &virt_wifi_ops;
-	dev->needs_free_netdev  =3D true;
+	dev->needs_free_netdev =3D true;
 }
=20
-/* Called in a RCU read critical section from netif_receive_skb */
+/* Called in a RCU read critical section from netif_receive_skb. */
+/* Aquires and releases virt_wifi_connection_lock. */
 static rx_handler_result_t virt_wifi_rx_handler(struct sk_buff **pskb)
 {
+	bool is_connected =3D false;
 	struct sk_buff *skb =3D *pskb;
 	struct virt_wifi_netdev_priv *priv =3D
 		rcu_dereference(skb->dev->rx_handler_data);
=20
-	if (!priv->is_connected)
+	read_lock(&virt_wifi_connection_lock);
+	is_connected =3D priv->connection.is_connected;
+	read_unlock(&virt_wifi_connection_lock);
+
+	if (!is_connected)
 		return RX_HANDLER_PASS;
=20
 	/* GFP_ATOMIC because this is a packet interrupt handler. */
@@ -566,12 +1445,34 @@ static int virt_wifi_newlink(struct net *src_net, st=
ruct net_device *dev,
=20
 	dev->priv_destructor =3D virt_wifi_net_device_destructor;
 	priv->being_deleted =3D false;
-	priv->is_connected =3D false;
 	priv->is_up =3D false;
-	INIT_DELAYED_WORK(&priv->connect, virt_wifi_connect_complete);
+	priv->connect_req_ctx =3D NULL;
+	INIT_WORK(&priv->connect, virt_wifi_connect_complete);
+	INIT_WORK(&priv->disconnect, virt_wifi_disconnect_complete);
+
+	write_lock(&virt_wifi_connection_lock);
+	priv->connection.is_connected =3D false;
+	eth_zero_addr(priv->connection.bssid);
+	priv->connection.signal =3D 0;
+	write_unlock(&virt_wifi_connection_lock);
+
+	priv->connection.tx_packets =3D 0;
+	priv->connection.tx_failed =3D 0;
+
+	priv->request_port =3D HV_WIFI_REQUEST_PORT;
+	priv->notification_port =3D HV_WIFI_NOTIFICATION_PORT;
+
+	err =3D setup_notification_channel(priv, priv->notification_port);
+	if (err) {
+		dev_err(&priv->lowerdev->dev,
+			"can't start the notification channel: %d\n", err);
+		goto unregister_netdev;
+	}
+
 	__module_get(THIS_MODULE);
=20
 	return 0;
+
 unregister_netdev:
 	unregister_netdevice(dev);
 free_wireless_dev:
@@ -594,12 +1495,20 @@ static void virt_wifi_dellink(struct net_device *dev=
,
=20
 	priv->being_deleted =3D true;
 	virt_wifi_cancel_connect(dev);
+
+	kfree(priv->connect_req_ctx);
+	priv->connect_req_ctx =3D NULL;
+
 	netif_carrier_off(dev);
=20
+	// Stop handling notifications
+	stop_notification_channel(priv);
+
 	netdev_rx_handler_unregister(priv->lowerdev);
 	netdev_upper_dev_unlink(priv->lowerdev, dev);
=20
 	unregister_netdevice_queue(dev, head);
+
 	module_put(THIS_MODULE);
=20
 	/* Deleting the wiphy is handled in the module destructor. */
@@ -654,8 +1563,7 @@ static int __init virt_wifi_init_module(void)
 {
 	int err;
=20
-	/* Guaranteed to be locallly-administered and not multicast. */
-	eth_random_addr(fake_router_bssid);
+	printk(KERN_DEBUG "%s:\n", __func__);
=20
 	err =3D register_netdevice_notifier(&virt_wifi_notifier);
 	if (err)
@@ -682,6 +1590,8 @@ static int __init virt_wifi_init_module(void)
 /* Acquires and releases the rtnl lock. */
 static void __exit virt_wifi_cleanup_module(void)
 {
+	printk(KERN_DEBUG "%s:\n", __func__);
+
 	/* Will delete any devices that depend on the wiphy. */
 	rtnl_link_unregister(&virt_wifi_link_ops);
 	virt_wifi_destroy_wiphy(common_wiphy);
--=20
2.23.4
