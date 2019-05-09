Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC318761
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEIJC6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:02:58 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:25101
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfEIJC6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuIflwrXXHWNMyPOF/LbcAoYcDJtq9U1LahscHARRBE=;
 b=Cl0blMU6B9OXRaV5vRd6cDxtHOe40Ci5aKqyEQzQTXvRpVvkdGDP94NILNdj27VXNvTtg1fln8dwFVvfbhKzKmQWxlqhI2j0eRz6axCFQcdTraeqCmv1j9ImdfXtVQ8CAzFV2ma1yZsIRzRpXJ/gPFTxSxwjrrM2vgm6X8aem98=
Received: from BN8PR06MB6291.namprd06.prod.outlook.com (20.178.215.213) by
 BN8PR06MB5540.namprd06.prod.outlook.com (20.178.210.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 09:02:52 +0000
Received: from BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65]) by BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65%7]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 09:02:52 +0000
From:   Stanley Hsu <Stanley.Hsu@cypress.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
CC:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 5/6] cfg80211: add support for SAE authentication offload
Thread-Topic: [PATCH 5/6] cfg80211: add support for SAE authentication offload
Thread-Index: AQHUo/RNj9f6v3v5e0G194Uvkb4gAqWe9CmAgMRP3gA=
Date:   Thu, 9 May 2019 09:02:52 +0000
Message-ID: <20190509090246.GC74912@aremote06.aus.cypress.com>
References: <1546582221-143220-1-git-send-email-chi-hsien.lin@cypress.com>
 <1546582221-143220-5-git-send-email-chi-hsien.lin@cypress.com>
 <6c17fb65-d070-51d5-17cf-4d6788e8cbcb@broadcom.com>
In-Reply-To: <6c17fb65-d070-51d5-17cf-4d6788e8cbcb@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To BN8PR06MB6291.namprd06.prod.outlook.com
 (2603:10b6:408:57::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanley.Hsu@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.110.209.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1600d8e6-b10c-4842-7d41-08d6d45d1e00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR06MB5540;
x-ms-traffictypediagnostic: BN8PR06MB5540:
x-microsoft-antispam-prvs: <BN8PR06MB55404C2A406AFD527B663A79F0330@BN8PR06MB5540.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(396003)(346002)(51914003)(189003)(199004)(186003)(478600001)(4326008)(316002)(6916009)(66066001)(86362001)(8936002)(7736002)(305945005)(14454004)(26005)(72206003)(33656002)(6512007)(6246003)(6436002)(2906002)(54906003)(6116002)(71190400001)(3846002)(71200400001)(81156014)(8676002)(81166006)(476003)(486006)(11346002)(256004)(446003)(6486002)(53936002)(5024004)(14444005)(1076003)(76176011)(229853002)(44832011)(99286004)(68736007)(102836004)(66476007)(66556008)(64756008)(66446008)(73956011)(25786009)(386003)(6506007)(53546011)(52116002)(5660300002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR06MB5540;H:BN8PR06MB6291.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vfm1qQBXjcNRsw8acpYNinS0xi1bQoLUqCT7BOwANhGe4y1YO3Ep5wXZC3sEaVGC69A7/ZUqSeZs88mQ0rnXzsdIBVL/f51URfumHy5au1CMfsopXlRn+f0L2Nlui+K5eCQ2dzc2sjwYsEEdD0SW8wOpwUPDjqrKPpT86cpYi7i2crrCyLryijmbeeJ2rr4yrxCcokUGT6+zGCDQHx2inRfgiIByAbKEpyLw30bKM/6cSrF/Su0QXkd9Tntdpz8OsfloNqsxetWWrVoLme90QA3cQT1sncFlO3+tA/3ubtv4ZWk6ioLrOSj9RGvbP1j7fXSmpWkeMx950NPK9YpTyc388VeMYhXWWILd/6mDe1MczZ3VUd4vCQndOYapGsr0wfo0o+vKc2+4NpIVs7kYtXsPoYkgkgybQgDQOhN0Btw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC5E14249658C844A61C02A6896C2BF5@namprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1600d8e6-b10c-4842-7d41-08d6d45d1e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:02:52.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5540
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 04, 2019 at 12:10:01PM +0100, Arend Van Spriel wrote:
> On 1/4/2019 7:11 AM, Chi-Hsien Lin wrote:
> >From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> >
> >Let drivers advertise support for station-mode SAE authentication
> >offload with a new NL80211_EXT_FEATURE_SAE_OFFLOAD flag.
>
> When touching nl80211 api I prefer 'nl80211:' prefix instead of 'cfg80211=
:'.

Thanks for the comment. Will change it in V2.

>
> >Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> >Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> >---
> >  include/linux/ieee80211.h    |  1 +
> >  include/net/cfg80211.h       |  5 +++++
> >  include/uapi/linux/nl80211.h | 16 ++++++++++++++++
> >  net/wireless/nl80211.c       | 14 ++++++++++++++
> >  4 files changed, 36 insertions(+)
> >
> >diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> >index 3b04e72315e1..37d3e655e547 100644
> >--- a/include/linux/ieee80211.h
> >+++ b/include/linux/ieee80211.h
> >@@ -2596,6 +2596,7 @@ enum ieee80211_key_len {
> >  #define FILS_ERP_MAX_RRK_LEN64
> >  #define PMK_MAX_LEN64
> >+#define SAE_PASSWORD_MAX_LEN128
> >  /* Public action codes (IEEE Std 802.11-2016, 9.6.8.1, Table 9-307) */
> >  enum ieee80211_pub_actioncode {
> >diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> >index e0c41eb1c860..5809dac97b33 100644
> >--- a/include/net/cfg80211.h
> >+++ b/include/net/cfg80211.h
> >@@ -740,6 +740,9 @@ struct survey_info {
> >   *CFG80211_MAX_WEP_KEYS WEP keys
> >   * @wep_tx_key: key index (0..3) of the default TX static WEP key
> >   * @psk: PSK (for devices supporting 4-way-handshake offload)
> >+ * @sae_pwd: password for SAE authentication (for devices supporting SA=
E
> >+ *offload)
> >+ * @sae_pwd_len: length of SAE password (for devices supporting SAE off=
load)
> >   */
> >  struct cfg80211_crypto_settings {
> >  u32 wpa_versions;
> >@@ -755,6 +758,8 @@ struct cfg80211_crypto_settings {
> >  struct key_params *wep_keys;
> >  int wep_tx_key;
> >  const u8 *psk;
> >+const u8 *sae_pwd;
> >+u16 sae_pwd_len;
>
> Not really need u16 as max length is defined earlier as 128.

It will be changed to u8 in V2.

>
> >  };
> >  /**
> >diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> >index 12762afb3a07..4840aaed39ba 100644
> >--- a/include/uapi/linux/nl80211.h
> >+++ b/include/uapi/linux/nl80211.h
> >@@ -235,6 +235,15 @@
> >   */
> >  /**
> >+ * DOC: SAE authentication offload
> >+ *
> >+ * By setting @NL80211_EXT_FEATURE_SAE_OFFLOAD flag drivers can indicat=
e they
> >+ * support offloading SAE authentication for WPA3-Personal networks. In
> >+ * %NL80211_CMD_CONNECT the password for SAE should be specified using
> >+ * %NL80211_ATTR_SAE_PASSWORD.
> >+ */
> >+
> >+/**
> >   * enum nl80211_commands - supported nl80211 commands
> >   *
> >   * @NL80211_CMD_UNSPEC: unspecified command to catch errors
> >@@ -2288,6 +2297,9 @@ enum nl80211_commands {
> >   *
> >   * @NL80211_ATTR_FTM_RESPONDER_STATS: Nested attribute with FTM respon=
der
> >   *statistics, see &enum nl80211_ftm_responder_stats.
> >+ * @NL80211_ATTR_SAE_PASSWORD: attribute for passing SAE password mater=
ial. It
> >+ *is used with %NL80211_CMD_CONNECT to provide password for offloading
> >+ *SAE authentication for WPA3-Personal networks.
> >   *
> >   * @NL80211_ATTR_TIMEOUT: Timeout for the given operation in milliseco=
nds (u32),
> >   *if the attribute is not given no timeout is requested. Note that 0 i=
s an
> >@@ -2743,6 +2755,7 @@ enum nl80211_attrs {
> >  NL80211_ATTR_FTM_RESPONDER,
> >  NL80211_ATTR_FTM_RESPONDER_STATS,
> >+NL80211_ATTR_SAE_PASSWORD,
>
> Marcel already commented on this. These enumerations are ABI. You
> should also change the nl80211_policy to assure the max length
> SAE_PASSWORD_MAX_LEN is not exceeded.

It will be moved to the bottom. The corresponding change in
nl80211_policy has been made.

Regards,
Chung-Hsien

>
> Gr. AvS

This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
