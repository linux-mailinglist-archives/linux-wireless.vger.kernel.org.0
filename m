Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE84ED807
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiCaK6M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiCaK6K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 06:58:10 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347341E3743
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648724183; x=1649328983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uTYGAXHh5qYvM11enszz3gajJ5KtrSqMn5KRkWOkmDI=;
  b=LYf8a5XSI930ykV609QIQkjDXnBwdfokG62yf5WhZ8y30Npa+G18auiL
   hMvIP6msDYGBX1k9PyARVFgPYGQDeZgFfh1Tv88m0eAk7/UQY5W2UkgBB
   +zjjq9uBv2uYRqWn1jYyH5IwFRZKB6MYLiYlvYruoX+KrplC75bSm++t/
   4=;
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh/W1l4aQcPAuKcjKDqmR3Lq4//GFO4j+amfyDbRjuMl3N7uslacBzaW1HfE5tKu0oDOTnar0/kjU7W/L43GiLKYzD4hQ/cQR/Y4Ph8OrfGARxjXhzSTY6tUceujUkJUeFzC5rfX/AVPosUMByTB0uhaKgr2e1Fs8pn5c8iuZvyNgRr4v0KdNwSG4Qfkohw7Kc2hq9OvYthD9tzPz3X1SjaTRLNLe9mpSmZK8FQ3EiNxWAU2NPugmkdIXbaW1g7t23PruehgfXIo6pZovPEctNdfi4+hvxzj3qXMagAQbVmiTMJIJKK5++3+cbacH6m/ZkhtgcFoVFBrkXMu0Qp0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTYGAXHh5qYvM11enszz3gajJ5KtrSqMn5KRkWOkmDI=;
 b=dBpUokjd46T7VOwB9ADIwc3AOb5I72xntXvINf/S3F+RN/1T6H6Xk8gSXq+EZWUGmqidQu5C++iu94G7twrR92VAQvdi4i9g/4mLm/voBFrl2YLB1qwTjVW/TXx0jlEsfNa1nwmSyUXi3eMFB7rcDGJgsl4XyT0oj04KECF7z4x1BpxV9zEPzvGK4dtynWfha5K96HDb2QoHZdt0xHFCnJ3wCHsHNaiva+CHrqKbXhAlHuOmnBjRQk384g3ZNzNeVBAcnMsBCgq3puE6u29X80zSV/DwwaRTx3+mNUqh8BRInbvBZUogWzi8tnsp2T9L9jVlXyS4m2z/5pJW2+VDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from MW2PR02MB3899.namprd02.prod.outlook.com (2603:10b6:907:3::30)
 by BL0PR02MB5425.namprd02.prod.outlook.com (2603:10b6:208:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 10:56:16 +0000
Received: from MW2PR02MB3899.namprd02.prod.outlook.com
 ([fe80::d163:1cf6:9fda:4b82]) by MW2PR02MB3899.namprd02.prod.outlook.com
 ([fe80::d163:1cf6:9fda:4b82%4]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 10:56:16 +0000
From:   "Nagarajan Maran (QUIC)" <quic_nmaran@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Nagarajan Maran (QUIC)" <quic_nmaran@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v5.18] ath11k: fix driver initialization failure with WoW
 unsupported hw
Thread-Topic: [PATCH v5.18] ath11k: fix driver initialization failure with WoW
 unsupported hw
Thread-Index: AQHYRNFW+lpV0OMIdUmEcCGwKggX46zZTwVggAACpOA=
Date:   Thu, 31 Mar 2022 10:56:15 +0000
Message-ID: <MW2PR02MB38991A500275B04A9481BF78EDE19@MW2PR02MB3899.namprd02.prod.outlook.com>
References: <20220331073110.3846-1-quic_nmaran@quicinc.com>
 <87sfqyv1td.fsf@kernel.org>
In-Reply-To: <87sfqyv1td.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d06f947-887c-4a48-45e4-08da13051462
x-ms-traffictypediagnostic: BL0PR02MB5425:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB5425773B5334EF91FA50214891E19@BL0PR02MB5425.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tCAv+WCUfx5eCdAM8JBkwb2ZgA5nrOsa/uUE1lRGSoCPvO83/Xh/89pzngZrHJjWyOGb70EtNO+EPsJec40on4Rby88BotRVaxe4+oWlGXJm/5bfLRVhHqJ0smdjw20i/t7sIoreVMyBc/4yahjdDp1rUoC7TYKSaJk6C2kBRBDh3wOmh75Zqvj8nVjTyybZbGLEzjBm8XSMxNE5h4UbxH6mAKFRWxYHPLp4oVQfdkEjI5YVGtXwtYHPrYKqiTzMhg2U7ss20/h9V4U6V0MKKfMgdUa+wfTiTFpp8+beV9ZqyJARbix235Uv9YpZsawlnTtkVQSuhJT/c6E4msvb+r2PW1B3dCIvoExDNGBaYprG+dxDPUu3ntmLT/HOXR4OgTreJs+FnQcxXFnPII5dL5TLyjfe2CVrYjTwX3wStxzgFV4ATkccVtjZCrVCzCR8ZH0L1EA88iWDbArK113ttE/FDYeGW2ETBVNPB5QN8QkPI+xoKfXp5Gd8SiPE5OX/FzP80gIwdX8wfXG8WUgqSNoZbEr4BKG1JwkV+LRLSk0gqAxG/VsRGOL0/aKn0iCAeozwPA64ef34IZrepOvrWLphuo1DH0+iLmsVfz5spYhdxbXdTx7wyWLPkdF9ORcomS9ZMS7u4MojZJNIoFV977mOG9/FzGXfBQmrklof3AORnd8mymZJxrsKMZBoytlWUWxw/tWznKig2jchwEfaGiATRAJMfAC5BbV7dfXfSmF4hpaLvROesfxrHAGgYvR+9WKDiQHalvUPYNIKG13bIT5lvF2SE5HDfkgyYKV8cgaFt3YM6/gMxytaQe72ybaSAU+8hjgxTjBCuHZw+W37hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR02MB3899.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(76116006)(7696005)(110136005)(6506007)(45080400002)(54906003)(33656002)(55016003)(71200400001)(9686003)(2906002)(38100700002)(8936002)(966005)(508600001)(316002)(5660300002)(66556008)(66476007)(26005)(64756008)(122000001)(66946007)(52536014)(86362001)(83380400001)(66446008)(8676002)(4326008)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EvsTY/EBoOFn2FFbQv9VHcOH0dgx/pS/tfWcIjJE1afblaLOyigyAg7SBfwv?=
 =?us-ascii?Q?fNTbI7cxKhn2J2n8vAgn3Bf41jLDvFZGKh3GFXxk920t0uc2z6HQLfT+6vr0?=
 =?us-ascii?Q?1XxIWnrOKgq4OKc9dD9Zs07RtB+XemXJtyc1CqsFZWUuKzwsNe82sEXdSm8J?=
 =?us-ascii?Q?ORUW75UmbB2FnbpcXoVqprF8EA5LdOjy2MIIcMgnUxTbe2qkJNwylVuJMCr1?=
 =?us-ascii?Q?h+9hjL2aQRLluE12p5eg+k0zgxbjDO4ccCky1JaPwMNri/TLy0/LnwPyqqz7?=
 =?us-ascii?Q?fq17V1S2xLFngiWaN4OxW2SbT9B2+dmuio/V2uBoWpoQsTfpBGsbqQQ/d9bF?=
 =?us-ascii?Q?OhIcpXvtjxNjEuwErK+t6cKORXCFuYKaqwvIce2UlhrJAgIhk5pwtNDSnPif?=
 =?us-ascii?Q?+ZCB1V6LDh5hfZpfFDB1FzMP5pcFNpyKX7XJW7o5jemjvIpe44rF2qLUi5Ud?=
 =?us-ascii?Q?Z1H+gNgbQoaI+64i3HxlyuuMjL7WLEKVYViexGpWBe60X3eWK4Bx+1Wd5eyj?=
 =?us-ascii?Q?YuZ04zy6mSX0x3xHsSWJW3n4aJJ9rDka336rDh3n+GNjDF7txQqUntHkS0oN?=
 =?us-ascii?Q?P5zPtG7pG4E6d6JfXcFYujf8+FEL5sUlx0rfQgcXmOT0EzyfdxS98XL/GZpD?=
 =?us-ascii?Q?8rrqiueBIyWD8CbKYdBIZQWqbY+BHDBKkrmq2nbjoUWXlr8Pax03iS7LNDNW?=
 =?us-ascii?Q?IJ76JTfOvZtXbmflUQ+fs/a2+YbJFpiwqu2vHzsSZDzEpw4SenRbDRZgoVj4?=
 =?us-ascii?Q?BbxswbZzPJQiENyM0vKOQHmdmzcIdYvP0ywmHaAWxZfGGaWchQeGV8OwXb8O?=
 =?us-ascii?Q?DDet7SIi8nD3pGyQWx4IdcsFJYI798PG5uNyPvg2eQ1vbqb1N8ohBryB4QB5?=
 =?us-ascii?Q?9qz0/PPWoTi5Sulgw5rryqRYCN/30p3wYKXDW40C4avrqK8QxgWQzxaTUEfh?=
 =?us-ascii?Q?ePYVEXqHMLkKcguQnDSOLhU9ICTYRZvcwtUlsDarc2FRKme3vrrzXHH+UBz1?=
 =?us-ascii?Q?22XgO1hn27OZ5duztlh+Gm+mS2eaxuoWRPCSP5yFyJ0d5F8TSwuMj0cG2fyY?=
 =?us-ascii?Q?bXWQYRtw2vDv3fs4NEq1MiHa6q0eJtY+kF3qfRCn5BRIxibIMf7NmPsOqPoG?=
 =?us-ascii?Q?0bqSeo4/+t2jKFvGUTGYhydC8bmRKrCeemu/tk5AxNi1aqJJgp/XIDRFlGzG?=
 =?us-ascii?Q?qQYDYWNdlkt3MVzUqNbGuzAAb1stMc1fllCLXFCuWUQSp0avA/4I6/iq8NQf?=
 =?us-ascii?Q?9lRVgAFh8Bum7VAVEhHWV8mzRYOE62asWrOisvTI/NFGwq1kZrkSVbFZJWkO?=
 =?us-ascii?Q?zT//5tRx+6FOThDhRPvH6AvMcnoMZl6oWiSbiCC+UEC2mkTxkzjbqPqY0AyU?=
 =?us-ascii?Q?jZs+lo4eVOjTk+B89r7PEnX5wVdHois4DmaGFc1VN4mUes3YL7++/ucHpTtI?=
 =?us-ascii?Q?k5AE2YKnVMmXgLbvAp7M/D3mzREEd1n4yQ1TSu7YaJTSSON58Yda7OzRB2hz?=
 =?us-ascii?Q?ZwVAXbUWH9nw3L8dSyp2LEgtkCDx26eQloQh33P4es1yv0HGEC/O3CGKqCFY?=
 =?us-ascii?Q?7ix3E4wLau1cZYzGfWG5MZRYA9Lekz9tx8ccDhyCCT8nrDEK4bgJsp3cNZDu?=
 =?us-ascii?Q?4I1mnwhGYmp9Lcnuo6y9fUbluqVYLpd2u4ERkMiov5DWT6tXzYhFbde5WHC7?=
 =?us-ascii?Q?VPjLy1jimAdi4p19yYKeTAoBypvVpIODBUWVRsIwjIGYRLASweDYYYFlu7bp?=
 =?us-ascii?Q?B3MRA/9KQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3899.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d06f947-887c-4a48-45e4-08da13051462
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 10:56:15.7064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6scGiywLdVqUmx02ZBbmutDNjqvL9/pbQ0C4T35zNkWwZZGDtqou9UIJ/ZBwAC1zj1BFkKiXQNSCN9GgiEHKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5425
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



-----Original Message-----
From: Kalle Valo <kvalo@kernel.org>=20
Sent: Thursday, March 31, 2022 4:15 PM
To: Nagarajan Maran (QUIC) <quic_nmaran@quicinc.com>
Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.18] ath11k: fix driver initialization failure with W=
oW unsupported hw

Nagarajan Maran <quic_nmaran@quicinc.com> writes:

> In the "ath11k_wow_init", error value "EINVAL" is returned when the=20
> check for firmware support of WoW feature fails, which in turn stops=20
> the driver initialization.
>
> Warning message:
> [   31.040144] ------------[ cut here ]------------
> [   31.040185] WARNING: CPU: 1 PID: 51 at drivers/net/wireless/ath/ath11k=
/wow.c:813 ath11k_wow_init+0xc8/0x13a8 [ath11k]
> [   31.043846] Modules linked in: ath11k_pci ath11k qmi_helpers
> [   31.054341] CPU: 1 PID: 51 Comm: kworker/u8:1 Tainted: G        W	5.17=
.0-wt-ath-594817-ga7f6aa925cf8-dirty #17
> [   31.060078] Hardware name: Qualcomm Technologies, Inc. IPQ8074/AP-HK10=
-C2 (DT)
> [   31.070578] Workqueue: ath11k_qmi_driver_event ath11k_qmi_driver_event=
_work [ath11k]
> [   31.077782] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   31.085676] pc : ath11k_wow_init+0xc8/0x13a8 [ath11k]
> [   31.092359] lr : ath11k_mac_register+0x548/0xb98 [ath11k]
> [   31.097567] sp : ffff80000aa13c40
> [   31.102944] x29: ffff80000aa13c40 x28: ffff800009184390 x27: ffff00000=
2959f20
> [   31.106251] x26: ffff000002828000 x25: ffff000002830000 x24: ffff00000=
2830000
> [   31.113369] x23: ffff000002820000 x22: ffff00000282854c x21: 000000000=
0000000
> [   31.120487] x20: ffff00000295cf20 x19: ffff000002828540 x18: 000000000=
0000031
> [   31.127605] x17: 0000000000000004 x16: ffff0000028285fc x15: ffff00000=
295b040
> [   31.134723] x14: 0000000000000067 x13: ffff00000282859c x12: 000000000=
000000d
> [   31.141840] x11: 0000000000000018 x10: 0000000000000004 x9 : 000000000=
0000000
> [   31.148959] x8 : ffff00000289d680 x7 : 0000000000000000 x6 : 000000000=
000003f
> [   31.156077] x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff00000=
2820968
> [   31.163196] x2 : 0000000000000080 x1 : 0080008af9981779 x0 : ffff00000=
2959f20
> [   31.170314] Call trace:
> [   31.177421]  ath11k_wow_init+0xc8/0x13a8 [ath11k]
> [   31.179684]  ath11k_core_qmi_firmware_ready+0x430/0x5e0 [ath11k]
> [   31.184548]  ath11k_qmi_driver_event_work+0x16c/0x4f8 [ath11k]
> [   31.190623]  process_one_work+0x134/0x350
> [   31.196262]  worker_thread+0x12c/0x450
> [   31.200340]  kthread+0xf4/0x110
> [   31.203986]  ret_from_fork+0x10/0x20
> [   31.207026] ---[ end trace 0000000000000000 ]---
> [   31.210894] ath11k_pci 0000:01:00.0: failed to init wow: -22
> [   31.215467] ath11k_pci 0000:01:00.0: failed register the radio with ma=
c80211: -22
> [   31.221117] ath11k_pci 0000:01:00.0: failed to create pdev core: -22
>
> Fix this by returning value "0" when FW doesn't support WoW to allow=20
> driver to proceed with initialize sequence and also remove the=20
> unnecessary "WARN_ON".
>
> Fixes: ba9177fcef21 ("Add basic WoW functionalities")
> Tested-on: QCN9074 hw1.0 PCI=20
> WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>

>Fixes tag is wrong, it should be:

>Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")

>I fixed it in the pending branch.

Thanks, Kalle. Will note this for the my next reviews.

--
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
