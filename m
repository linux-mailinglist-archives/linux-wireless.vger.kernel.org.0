Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755971879F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfEIJVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:21:18 -0400
Received: from mail-eopbgr790137.outbound.protection.outlook.com ([40.107.79.137]:18366
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfEIJVR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe3gP818W11g4Q6PTbzRewY+Hxh5mMQY63cytdGySv0=;
 b=NBP0n4RBDuLifZr9moZFNCRn/CuLfR2Kd6xa78KwQGQ5OqxIff99VMRhEFJxpDnSmsE0t5D1hs9ZjEhDNHS6YpOoqgHxEUCFKKNxoIZMErq2Xof3+wmEVesZzmtCSVkCXb+d3gucIP8Nb8iZPAQoeIKdb35fH28kGKwEAzWAP1c=
Received: from BN8PR06MB6291.namprd06.prod.outlook.com (20.178.215.213) by
 BN8PR06MB5364.namprd06.prod.outlook.com (20.178.208.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 09:21:12 +0000
Received: from BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65]) by BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65%7]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 09:21:12 +0000
From:   Stanley Hsu <Stanley.Hsu@cypress.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 5/6] cfg80211: add support for SAE authentication offload
Thread-Topic: [PATCH 5/6] cfg80211: add support for SAE authentication offload
Thread-Index: AQHUo/RNj9f6v3v5e0G194Uvkb4gAqWe10GAgMRx4oA=
Date:   Thu, 9 May 2019 09:21:12 +0000
Message-ID: <20190509092103.GD74912@aremote06.aus.cypress.com>
References: <1546582221-143220-1-git-send-email-chi-hsien.lin@cypress.com>
 <1546582221-143220-5-git-send-email-chi-hsien.lin@cypress.com>
 <2FC4C72C-9E57-4195-A682-F7BAE7F3981E@holtmann.org>
In-Reply-To: <2FC4C72C-9E57-4195-A682-F7BAE7F3981E@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:805:8e::34) To BN8PR06MB6291.namprd06.prod.outlook.com
 (2603:10b6:408:57::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanley.Hsu@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.110.209.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da0260d5-debd-43a1-2ad1-08d6d45fad7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR06MB5364;
x-ms-traffictypediagnostic: BN8PR06MB5364:
x-microsoft-antispam-prvs: <BN8PR06MB5364F953B9E1CB773B23E20AF0330@BN8PR06MB5364.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(14454004)(446003)(6246003)(8936002)(6916009)(8676002)(73956011)(476003)(102836004)(1076003)(86362001)(71190400001)(71200400001)(6506007)(386003)(11346002)(478600001)(229853002)(53936002)(76176011)(486006)(316002)(186003)(72206003)(54906003)(33656002)(52116002)(64756008)(66556008)(4326008)(66946007)(26005)(66476007)(25786009)(7736002)(305945005)(2906002)(5660300002)(66446008)(81166006)(66066001)(81156014)(44832011)(6486002)(68736007)(6116002)(3846002)(6512007)(6436002)(14444005)(256004)(5024004)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR06MB5364;H:BN8PR06MB6291.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ux+yAVBXMWVfrMsCxUG6SIW8PlUQG9QZzdX+TsBSbMp9kUo19fZTVSuA+K7Ag0xegyYTbbKwbvwbzJdjhQ8OdjvzEqA+jfRbjGEM8NWAWItRAPZ1f3cq4MvAqM//gs8PtLj0a6TShGOPA4EDn36x2XPs2YquZvYWNOLKPvXD07aQUzg4lgtdGfD2WKsttE0UY5eA2dRjTlpSHqdgH2bileeDji5W8Pe3syLG6ToIFkHIXE5P5BUiEOUo075Qrp13WkKDhn8h6AeI10OBLyzduDJB9rrww1PbZ4wtLP9YKvIWoB/BN2KofMMBp269v9pIl93XJ2J4sTAGwzkOXbsvE3QvzWzezsMoiuUCMRHaj2E+Ce41Y4xI5CcPbpeDW5CqOur6JyS3lMgcRtQSo3QqMsTSILe0MKSluGy47mFXc9M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C6D612ACE60804884ECB844AEA53C62@namprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0260d5-debd-43a1-2ad1-08d6d45fad7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:21:12.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5364
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 04, 2019 at 10:26:33AM +0100, Marcel Holtmann wrote:
> Hi,
>
> > Let drivers advertise support for station-mode SAE authentication
> > offload with a new NL80211_EXT_FEATURE_SAE_OFFLOAD flag.
> >
> > Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> > Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> > ---
> > include/linux/ieee80211.h    |  1 +
> > include/net/cfg80211.h       |  5 +++++
> > include/uapi/linux/nl80211.h | 16 ++++++++++++++++
> > net/wireless/nl80211.c       | 14 ++++++++++++++
> > 4 files changed, 36 insertions(+)
> >
> > diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> > index 3b04e72315e1..37d3e655e547 100644
> > --- a/include/linux/ieee80211.h
> > +++ b/include/linux/ieee80211.h
> > @@ -2596,6 +2596,7 @@ enum ieee80211_key_len {
> > #define FILS_ERP_MAX_RRK_LEN64
> >
> > #define PMK_MAX_LEN64
> > +#define SAE_PASSWORD_MAX_LEN128
> >
> > /* Public action codes (IEEE Std 802.11-2016, 9.6.8.1, Table 9-307) */
> > enum ieee80211_pub_actioncode {
> > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > index e0c41eb1c860..5809dac97b33 100644
> > --- a/include/net/cfg80211.h
> > +++ b/include/net/cfg80211.h
> > @@ -740,6 +740,9 @@ struct survey_info {
> >  *CFG80211_MAX_WEP_KEYS WEP keys
> >  * @wep_tx_key: key index (0..3) of the default TX static WEP key
> >  * @psk: PSK (for devices supporting 4-way-handshake offload)
> > + * @sae_pwd: password for SAE authentication (for devices supporting S=
AE
> > + *offload)
> > + * @sae_pwd_len: length of SAE password (for devices supporting SAE of=
fload)
> >  */
> > struct cfg80211_crypto_settings {
> > u32 wpa_versions;
> > @@ -755,6 +758,8 @@ struct cfg80211_crypto_settings {
> > struct key_params *wep_keys;
> > int wep_tx_key;
> > const u8 *psk;
> > +const u8 *sae_pwd;
> > +u16 sae_pwd_len;
> > };
> >
> > /**
> > diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.=
h
> > index 12762afb3a07..4840aaed39ba 100644
> > --- a/include/uapi/linux/nl80211.h
> > +++ b/include/uapi/linux/nl80211.h
> > @@ -235,6 +235,15 @@
> >  */
> >
> > /**
> > + * DOC: SAE authentication offload
> > + *
> > + * By setting @NL80211_EXT_FEATURE_SAE_OFFLOAD flag drivers can indica=
te they
> > + * support offloading SAE authentication for WPA3-Personal networks. I=
n
> > + * %NL80211_CMD_CONNECT the password for SAE should be specified using
> > + * %NL80211_ATTR_SAE_PASSWORD.
> > + */
> > +
> > +/**
> >  * enum nl80211_commands - supported nl80211 commands
> >  *
> >  * @NL80211_CMD_UNSPEC: unspecified command to catch errors
> > @@ -2288,6 +2297,9 @@ enum nl80211_commands {
> >  *
> >  * @NL80211_ATTR_FTM_RESPONDER_STATS: Nested attribute with FTM respond=
er
> >  *statistics, see &enum nl80211_ftm_responder_stats.
> > + * @NL80211_ATTR_SAE_PASSWORD: attribute for passing SAE password mate=
rial. It
> > + *is used with %NL80211_CMD_CONNECT to provide password for offloading
> > + *SAE authentication for WPA3-Personal networks.
> >  *
> >  * @NL80211_ATTR_TIMEOUT: Timeout for the given operation in millisecon=
ds (u32),
> >  *if the attribute is not given no timeout is requested. Note that 0 is=
 an
> > @@ -2743,6 +2755,7 @@ enum nl80211_attrs {
> > NL80211_ATTR_FTM_RESPONDER,
> >
> > NL80211_ATTR_FTM_RESPONDER_STATS,
> > +NL80211_ATTR_SAE_PASSWORD,
> >
> > NL80211_ATTR_TIMEOUT,
>
> so you are breaking user-space API on purpose here even when there was a =
clear comment where to add new attributes:
>
> /* add attributes here, update the policy in nl80211.c */

Hi Marcel,

Thanks for pointing this out. It was a mistake caused by rebasing the
patch. Will fix it in V2.

>
> More importantly, does this actually need a new attribute and you can not=
 utilize what has already been added for mesh? If this attribute is solely =
for offload cases, then it might be better named accordingly. Also I am cur=
ious on how mixed WPA1/WPA2/WPA3 network credentials are now provided to a =
CMD_CONNECT. So the CMD_CONNECT description might require an update as well=
.

This new attribute is used to pass the sae_password value, set in the
configuration file of wpa_supplicant, for offloading SAE authentication.
It seems that the existing attributes can not be utilized for the
purpose. Could you please point it out if you know the proper one? To
reflect the content of the attribute, NL80211_ATTR_SAE_PASSWORD should
be a proper name.

As for the mixed WPA/WPA2/WPA3 network credentials, no key materials
will be provided in a NL80211_CMD_CONNECT for non-offload cases. When
offload is considered, there is no conflict between WPA/WPA2 4-way
handshake offload and SAE authentication offload. For the WPA/WPA2
4-way handshake offload, the PSK is specified using NL80211_ATTR_PMK in
the NL80211_CMD_CONNECT. The corresponding description can be found in
the section "DOC: WPA/WPA2 EAPOL handshake offload". As for the SAE
authentication offload, the sae_password value is provided by
NL80211_ATTR_SAE_PASSWORD in NL80211_CMD_CONNECT. It is described in
the section "DOC: SAE authentication offload" proposed in this patch.

Regards,
Chung-Hsien

>
> Regards
>
> Marcel
>

This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
