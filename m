Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7762418724
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfEII6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 04:58:46 -0400
Received: from mail-eopbgr780115.outbound.protection.outlook.com ([40.107.78.115]:9583
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfEII6q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 04:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KffyI65Ii3y3kt8ksUnmRnpmQSPHUmQOdThCTEd+hJc=;
 b=2SQ+/y92dvAvN7vQJj4uwFor6ez7W1MM3eJbwxVZD0KE+sKVxscnxu4IRRUfHmZt9amn4HfMIM4sxHkSErkJkprHJDbQo3NxeU+fl0PeGqeE4Iyc9UrD1E/LaLrCvQlMNiNynurnTsYYm3vHMeektqhJxgq0n+BZ1gq6EbnAnwE=
Received: from BN8PR06MB6291.namprd06.prod.outlook.com (20.178.215.213) by
 BN8PR06MB6274.namprd06.prod.outlook.com (20.178.215.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 08:58:42 +0000
Received: from BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65]) by BN8PR06MB6291.namprd06.prod.outlook.com
 ([fe80::65ff:9743:b958:8d65%7]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 08:58:42 +0000
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
Subject: Re: [PATCH 2/6] brcmfmac: send port authorized event for 802.1X 4-way
 handshake offload
Thread-Topic: [PATCH 2/6] brcmfmac: send port authorized event for 802.1X
 4-way handshake offload
Thread-Index: AQHUo/RKtFUXN/Oxt0O61RVrhqV/3aWjkyCAgL+vvQA=
Date:   Thu, 9 May 2019 08:58:42 +0000
Message-ID: <20190509085836.GB74912@aremote06.aus.cypress.com>
References: <1546582221-143220-1-git-send-email-chi-hsien.lin@cypress.com>
 <1546582221-143220-2-git-send-email-chi-hsien.lin@cypress.com>
 <d89b1304-471d-f064-02f1-6a9fab0ca25d@broadcom.com>
In-Reply-To: <d89b1304-471d-f064-02f1-6a9fab0ca25d@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0116.namprd05.prod.outlook.com
 (2603:10b6:803:42::33) To BN8PR06MB6291.namprd06.prod.outlook.com
 (2603:10b6:408:57::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanley.Hsu@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.110.209.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fef1de0e-743e-4c67-7a2b-08d6d45c8940
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR06MB6274;
x-ms-traffictypediagnostic: BN8PR06MB6274:
x-microsoft-antispam-prvs: <BN8PR06MB62746161E30781BF88069CA0F0330@BN8PR06MB6274.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(52116002)(99286004)(2906002)(8676002)(81156014)(81166006)(25786009)(476003)(386003)(14444005)(256004)(6506007)(5024004)(53546011)(8936002)(68736007)(76176011)(102836004)(53936002)(186003)(44832011)(66066001)(6246003)(54906003)(4326008)(6116002)(71200400001)(486006)(71190400001)(446003)(6916009)(11346002)(3846002)(26005)(7736002)(6486002)(6436002)(1076003)(305945005)(73956011)(66946007)(5660300002)(33656002)(86362001)(66556008)(64756008)(66446008)(66476007)(316002)(6512007)(72206003)(229853002)(478600001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR06MB6274;H:BN8PR06MB6291.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jrswmF9BFzACBfVqMxFZHXpOapV4I5yzgZhkRx4pqn4APWxqG83Jj5SLDJnY6Q8R2U/ospC+5bRGW2RsKvBfmq0WdcwL7Ku2M9wLhTJJzrDAHZVHT6oKJCf7ybwwejw2v2oR4Bxze67GkWvRRyGofV9bG3QqaK0NfvOEN0ybj3WS+DTuzXzRVhtqB9v8Eb9mN+az+KvF3XeWzwxmp2DrJYs1wndQAuGSwz+LyobBh1meSsk2eiAzdK6m4TzsWn8Lhm1+tLUTDk0pqhsSOieOti0IfDWUqYEB4nGO8bR+T06FHJCuBPnYe7IYdNt1MrqNUKUfn+PVzV637lKYDUgHXJ8ve4dU4Vb7ye3PfRITv9tM/CwcCr9r8rUAc60hq7LfxLxmrOepnK23IIHG+aR6rQVxxwV+VTZnfvVOd8hTN7Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E68940209033F4AAF5AC96D04FB9DF7@namprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef1de0e-743e-4c67-7a2b-08d6d45c8940
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 08:58:42.8635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6274
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 07, 2019 at 10:44:01AM +0100, Arend Van Spriel wrote:
> On 1/4/2019 7:11 AM, Chi-Hsien Lin wrote:
> >From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> >
> >With 4-way handshake offload for 802.1X authentication, a port
> >authorized event should be sent to user space after the completion of
> >4-way handshake. It is used to indicate that a connection is authorized
> >and 802.1X authentication is no longer required.
>
> It had been a while since I had looked at our offload code
> (basically since the initial implementation for the nl80211 work) so
> I was unsure why this would be needed.
>
> So initially we added a PORT_AUTHORIZED *attribute* in the nl80211
> api and later on the PORT_AUTHORIZED *event* was introduced and
> 4-way hs offload support in wpa_supplicant is ignoring the
> *attribute* and only handling the *event*. I think this information
> is important enough to add to this commit message with a reference
> to commit 503c1fb98ba3 ("cfg80211/nl80211: add a port authorized
> event") which "broke" the functionality in brcmfmac.

Thanks a lot for the feedback.
After looking further, it is observed that the connection state will be
set to WPA_COMPLETED in wpa_supplicant after it sets PMK to the driver.
So no need to have this change. Let's drop it form the series.

Regards,
Chung-Hsien

This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
