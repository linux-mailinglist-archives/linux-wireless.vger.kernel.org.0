Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA41870E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 10:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfEIIwD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 04:52:03 -0400
Received: from mail-eopbgr750091.outbound.protection.outlook.com ([40.107.75.91]:59909
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfEIIwD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 04:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65+CC/gJg9AqSo8nUjTIFW4TFPIljsFCkeYMBfp2pE8=;
 b=N4rz8NPxFu5fvXV56QUWc/PXmMBzsq0MCHa3VkT08lqpomJ0Xd5J34V8osme5Iftmw6JRGSIX2ZqNsUrATfDTQfYbDzOAxhCIyDWs44Ai8sgZfaQuLzaXRk+yJua4CN6Op9vwPDtoMXaR3MRZfrEGCyheoF3obDk+hX5gGfDRwA=
Received: from BN8PR06MB6291.namprd06.prod.outlook.com (20.178.215.213) by
 BN8PR06MB6242.namprd06.prod.outlook.com (20.178.216.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Thu, 9 May 2019 08:51:45 +0000
Received: from BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65]) by BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65%7]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 08:51:45 +0000
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
Subject: Re: [PATCH 1/6] nl80211: add NL80211_ATTR_IFINDEX to port authorized
 event
Thread-Topic: [PATCH 1/6] nl80211: add NL80211_ATTR_IFINDEX to port authorized
 event
Thread-Index: AQHUo/RIrwg9QxtW2Uu4Zr8hlj6YTaWe7vCAgMRR8IA=
Date:   Thu, 9 May 2019 08:51:45 +0000
Message-ID: <20190509085128.GA74912@aremote06.aus.cypress.com>
References: <1546582221-143220-1-git-send-email-chi-hsien.lin@cypress.com>
 <c8927d9e-09fc-e707-35b3-33a71966b29d@broadcom.com>
In-Reply-To: <c8927d9e-09fc-e707-35b3-33a71966b29d@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To BN8PR06MB6291.namprd06.prod.outlook.com
 (2603:10b6:408:57::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanley.Hsu@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.110.209.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac425831-ad00-4940-4a4a-08d6d45b9054
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR06MB6242;
x-ms-traffictypediagnostic: BN8PR06MB6242:
x-microsoft-antispam-prvs: <BN8PR06MB6242B5D7C06EFE3DDE797175F0330@BN8PR06MB6242.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(51914003)(305945005)(33656002)(7736002)(73956011)(11346002)(81166006)(446003)(66946007)(71200400001)(71190400001)(5660300002)(229853002)(81156014)(6916009)(8936002)(8676002)(6116002)(256004)(3846002)(6246003)(68736007)(5024004)(14444005)(2906002)(25786009)(4326008)(44832011)(14454004)(6486002)(6436002)(476003)(486006)(53936002)(72206003)(6512007)(478600001)(316002)(54906003)(66066001)(102836004)(52116002)(26005)(53546011)(86362001)(6506007)(386003)(76176011)(1076003)(99286004)(186003)(66446008)(64756008)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR06MB6242;H:BN8PR06MB6291.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mxIjPbnJ3lkPfkRS2CaEiX5omGQexl3acxah9sivwbahUZk13iGCduh5GCHL44sebp/hkbhhOj2MM8NjMt11czeZvhKeRfADdvVwnckFsmsKXsplYGA333SNT9VN5OmVU2LPSyekbp5k/iBHoljtjQkSTxrlVS7q03tCo3OVVc3bo5Ncryn459fUg4mtm0P3TrE1P+K96GcMIvBVAMOL/DDNW+1ypY9K2ziK8xJOlGQmac9Wr3isxYNl+Td2geZ1XCCE0kR4NBZPqRCjKLgcGsAP1bbcCDepMaP96oWz3xKEmuPF8fX4hUREBVvTAsKCE55NcHXkspqOLzWT6SQpst35Y3JbfoG2FoAv4Ufr/kWNkmwv3+h7vfjCCr4NbQWz3WM4aV5KtaRFAiqu0Um7XB7RteZCHlfFuiEvaeEd/H0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8AF6D632CEC2D4AB852E230CD0F7C18@namprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac425831-ad00-4940-4a4a-08d6d45b9054
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 08:51:45.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6242
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 04, 2019 at 11:51:19AM +0100, Arend Van Spriel wrote:
> On 1/4/2019 7:11 AM, Chi-Hsien Lin wrote:
> >From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> >
> >Add NL80211_ATTR_IFINDEX attribute to port authorized event to indicate
> >the operating interface of the device.
> >
> >Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> >Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> >---
> >  net/wireless/nl80211.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> >index 5e49492d5911..594aeba2982a 100644
> >--- a/net/wireless/nl80211.c
> >+++ b/net/wireless/nl80211.c
> >@@ -14727,7 +14727,8 @@ void nl80211_send_port_authorized(struct cfg8021=
1_registered_device *rdev,
> >  return;
> >  }
> >-if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
> >+if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
> >+    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
> >  goto nla_put_failure;
>
> Maybe also put NL80211_ATTR_WIPHY in the notification to be
> consistent with the other MLME notifications.

Thanks for the comment. Will include it in V2.

Regards,
Chung-Hsien
>
> Regards,
> Arend

This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
