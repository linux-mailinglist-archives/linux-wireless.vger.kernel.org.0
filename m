Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565FA4EECAB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbiDAMAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiDAMAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 08:00:18 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C0BD8
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1648814307; x=1649419107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9legM03dZ6QcqfKc9/O9E05YWIOkoeOhu3j5k6ruTCs=;
  b=CYK/XcLFnGNuyCqNrWllcx1HjG1SXYkQrrQspwi/TzEAsDZAgGZHDJoQ
   kOOlczMV82oheSVMnCCrrjEv5JPRQ+kTDsAqIRH4MiEb61yjNjQa8JKPk
   MWq5W41kI//bp3Y62phNIePxMOlzoWeKzv+MEf0tgskvw8BquR+ZfaTth
   U=;
Received: from mail-dm6nam08lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 11:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbKI7wwQHq+Sa1emskdIwjgCH/mBymW/rtPo7MTpBjX/OB/jIfCZDJEU+LFAKEr9Ul4RfqsHxMJ3DM/5vFsCzYKYL1baL9W5n/B7rTwpffu6V+o0kDiS6Yp7SCG96ICaGKzRTaotaXS5CC/hPO02SKaCo6hF06uA1xCzdSq8YgHXmHH4D/2bynbMs11OOJLAn0loP9iC39bTPifZ3KRTZKrgFwmveaDm/wPcaRjayUTqTqB+Ik0O5HgTu5FXoS6nKgYbMiGbtcnPAtpkGFTxVqaaAoRzU2BevNSjvXly+w2Y0uIHTKt2yHxzYwzJAT5V+1rM+bAgcjae0B38Iz2XlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9legM03dZ6QcqfKc9/O9E05YWIOkoeOhu3j5k6ruTCs=;
 b=ODioIbxSgVSIfznd/OTCAavbAHYupAvgRrZUbBUxWtn8uvsdnkRbaG4gxGdZ90I9H0NjFtrCTDKfmwzQOTlssN0A06tEAKAdOV6sVYcsOr16/1Idg+rQ78X32DBsluHbT7Qpv0Mu6LDxcGuYCXd/bDacSTz4R4Nsu/5ONCyAFm0shJUSsU4C5XvcRWG3U8hU2Ha/AF0Vxny/Rdd4NDjk8ri9QDbhXAATkDDZFfgV9XZ+WQtF/ibxdwTl4LXur4nA2FcUjyqtYLoEl+P5SplVZA+cLy8zSXvg2IBTdYBDj9U7qHlox5GxzkNRGDzgqICqZGHxHEA6k9MLZxeJm/FIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM6PR02MB6528.namprd02.prod.outlook.com (2603:10b6:5:1bb::8) by
 BN6PR02MB2531.namprd02.prod.outlook.com (2603:10b6:404:58::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.25; Fri, 1 Apr 2022 11:58:22 +0000
Received: from DM6PR02MB6528.namprd02.prod.outlook.com
 ([fe80::c473:1248:cd0:abd0]) by DM6PR02MB6528.namprd02.prod.outlook.com
 ([fe80::c473:1248:cd0:abd0%9]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 11:58:22 +0000
From:   Karthikeyan Kathirvel <kathirve@qti.qualcomm.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Karthikeyan Kathirvel (QUIC)" <quic_kathirve@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] ath11k: Change max no of active probe SSID and BSSID to
 fw capability
Thread-Topic: [PATCH] ath11k: Change max no of active probe SSID and BSSID to
 fw capability
Thread-Index: AQHYQ34QPurJnYWn+E+xN/pBYmaGJqza97xqgAAAgRA=
Date:   Fri, 1 Apr 2022 11:58:22 +0000
Message-ID: <DM6PR02MB65282E7996A040343F1EF4F1ECE09@DM6PR02MB6528.namprd02.prod.outlook.com>
References: <20220329150221.21907-1-quic_kathirve@quicinc.com>
 <87wng9t3vu.fsf@kernel.org>
In-Reply-To: <87wng9t3vu.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a07feb-5bd4-461d-ce49-08da13d6ebdb
x-ms-traffictypediagnostic: BN6PR02MB2531:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR02MB253134C8FD3B3C94B0FEEC8BECE09@BN6PR02MB2531.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0WWpwzN6HLTzWMYKr8FU/zL+k1x7aEDh/QWrofVecmZaqjQ/E514i+aroKearC4Cx2dCiu9QB5jvbD6XBlI+omiiFJL5k8PYqpDPdx6npB3EB+z+pLhU42JyHe9PxgtUXcktWp5jKzg+vTlmcvVeJNNs2/bIqVu7KpGBYpix7auvUlz6vi91M7baRVG6R8pZnxq2Y3Wzftnjeft5jaVL0UROl9CvzHo9okYJ7FOJAeqVKIEUCjIPe8VAk3ZXaxpFNLyxu4L76ygrveCENTnxdyT/ES94WBLUmtdIT4ABIjN0dhdo7xEYv0jXdP7tatp2QVb6IKw/Hu5be3M1gRmsfFBMVej3BcuwAzJUulHqs0N+EbQEkhcLAab2c0NXz2bdajptry1uJmcKAuvS0vlWtjvjmElBgIlrzEwYUcj8fo1rlKVyxSbYlf53EL2XJ4XyBxwdEIjaiMqQzd1zeD2Y2gb5lSCwgnA1MGtb6cjqFttidSexzXP8fGAQ8fEKTI9lvfvc/f0i0NZDFXHCcjpTkg0bzPommYV9dMWsFUhpnneiXxuudKFeplxxJ7RR4I9U+0pT+yhYwFff2x8pe9qyZfUg52VwdcwTvBy9InFvNfCA5ZkDt8SJoYfNAXRT4Ow63444OGEWILHyduNj2PO9EqQQ5WKR2QL+U1AEoVpuMG02vsE8yrMTvGLHfPm1O2D8IlM4KbmrihjGU/RjGHeKLr/ynSJumAcGD0Gm6UV1bNDwWOA9DHSkZhO3+pqbO5BcjbJfbydOi5+G9BYuiP0gX19FUroSwGosWqpbMkaDtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6528.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52536014)(38070700005)(316002)(38100700002)(186003)(66946007)(8676002)(8936002)(26005)(66556008)(9686003)(6506007)(7696005)(966005)(64756008)(66476007)(66446008)(4326008)(122000001)(33656002)(76116006)(54906003)(83380400001)(71200400001)(508600001)(55016003)(53546011)(55236004)(5660300002)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?43c91plLjSPOQqqaTKjRhoR05vjnPVTb+sAHVDXvfNuANcdrm9+aurwY793C?=
 =?us-ascii?Q?1xd8w9gD+RCaZaiArogygVPXmn7OmgX/cEeljh3hSgdzKfJiAglFPxl6+Pwf?=
 =?us-ascii?Q?Y5dxxaqlvcKEapI8/9iriiB9RNTK0SiO7NLm8bv9cnaIqvw7DrTkfqUHy1Z7?=
 =?us-ascii?Q?ARtphelTV8gn/kEwHEwNj8c93yxilmV9TVhxzG+g7EUuW8ibNCYJWhyDmKIf?=
 =?us-ascii?Q?uKfUItr9NFdG3TE+p72UjlQpJpu0FkvJowGfIBob+VdEglgOlZtFK5xawdPB?=
 =?us-ascii?Q?M2I4Upq/HAEsUzh5HrwNS2D6KFiReMKomNVez5GcmYGXMU7UGp0sDENMeKYA?=
 =?us-ascii?Q?dV4EC+1s0c7LwDmmYi6+6ds7wTgp7VnmJ9NKmf/r7qr1d54ilxsFcHOy7++r?=
 =?us-ascii?Q?NUbX9HbNh70Ld1gLEKRHVNLMY8vSyMUBdc/WYtUpngwcjDlPV9+vuLcp7Tly?=
 =?us-ascii?Q?mjfZH+Z+T/I6AgF6QwnM5l821d2VsSbxULXrK7IfJD3GW1P3tY+w2WcjAwB8?=
 =?us-ascii?Q?1Zbd0zx62apoO1OolzgoAVVz1jmpyukTFtLl8kXzi7LMcYtXljBtytKmWMYo?=
 =?us-ascii?Q?W5K54LeLBLTcO3n6UfxQuPCoyhC4apBOgBRDFFrkcqC4fEfxUL2rVCeI5U/1?=
 =?us-ascii?Q?15BbmOnBNIL/6zC7pKZ0CUbbEcPGF1nvBMm0CIopkGoAPzWyJqS+BEKIe3iM?=
 =?us-ascii?Q?EfrMbDzXyJ0E1t364A0Dd3dg5WYovzqpTfFdAN3txk8esz4/JrxN8fpNmXqY?=
 =?us-ascii?Q?PgdCHIQrD1IFi6GcYIVmxxEjaMiVZy33AsJ/74fqTooVxnQjVlfhvQiC6rar?=
 =?us-ascii?Q?yIMCDY0HFjlx/7oBwCUkPkka+GyjpKfVMToIOfkfcEnnOcfw9t+qp8k8EPCA?=
 =?us-ascii?Q?45E8Dwr28T75/OfMLSyrWWnH+oC2V57jP2NTHymHD5zxlnRz/nJ+n5HtMFXl?=
 =?us-ascii?Q?VUP3mVmD5jW/4aVst4rUPeJRnHmSQZC6YOETDYmXUsMK5WNwX1tWCKjN5X3y?=
 =?us-ascii?Q?rs1C5Q4TM76tvJTAksixOR1Vf/19ttoWAW52eg/ZhE+Si+GG65vDsOXd1hBv?=
 =?us-ascii?Q?SWOLvP3PEdsNjWhIfHtDo0dQrt+dY2/gZ+sNo4/25NxnuBqCEPJJLmjWhI4n?=
 =?us-ascii?Q?Rm5w+DIJOGyWnyxjZ/MjHqzk2OEeSfYkZIklqeYDovrKfp9fXMfXPjrpo53B?=
 =?us-ascii?Q?ORzKtdd6PcSyXHKxwTtEqHZ0q5Vmk52vCE4Of5HG/DNp2/I61WWYpDJhcET5?=
 =?us-ascii?Q?LRvt8o80NkY5g7wz0JELwhrsTzvpvXtsR4tuK7lDPGtwW4j1Cfnlq9Sv+Tp5?=
 =?us-ascii?Q?mgQWFK8tpECKmoymGkK0CqN5I8ZxGv0Hnj2r7xEZWyDCfu49jZu33aMR9IiX?=
 =?us-ascii?Q?61ehS3UMQaTDurGfygoBY+ssRFdRTzDlLiHfXddBtog9EFCqE9TSt4MnqfQq?=
 =?us-ascii?Q?DSRQlxWoe2CaagpUM4ONhvixFrJjfqq9UipOYTzN5J0AzT8DbEH7+aVyaj9P?=
 =?us-ascii?Q?ZbxWf5ZDt9fLzKJi0cn29doNYVICKMwjL9FH2K5FuhV1HzV2bFm2YTxU2O5c?=
 =?us-ascii?Q?lcHIKDHAtkFhwW4u3uqH3+cLjkXnGuwh8fI3QneeV8ydw4T1dHZmYTCW3HXl?=
 =?us-ascii?Q?aTxuUv6ta0SZ3XPPu46cGIQEkN9eU4oJDVtfHnwWnWQ8N5Yd9HhHxt2W2yUh?=
 =?us-ascii?Q?fZ6OX0TTc4K8QUb2Obh7uU5q2Ft4+zDaOwh0zohr2frR5pp8F5E2fEsJ0RD1?=
 =?us-ascii?Q?51mxoeRayg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6528.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a07feb-5bd4-461d-ce49-08da13d6ebdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 11:58:22.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GQoQ/jb7bHcbPWsI4akNjI4ky8U2MrjQthXkqVeLT6Hn31rMNxD5uvsvnmgON+/oZRD4ytZqgScevS0S/ua8ID56XzqMWAZBX8CDAoStTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2531
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Sorry I missed to add the hw details, I tested on IPQ8074 hw2.0 AHB

Thanks
Karthikeyan

-----Original Message-----
From: Kalle Valo <kvalo@kernel.org>=20
Sent: Friday, April 1, 2022 5:25 PM
To: Karthikeyan Kathirvel (QUIC) <quic_kathirve@quicinc.com>
Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: Change max no of active probe SSID and BSSID t=
o fw capability

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> The maximum number of SSIDs in a for active probe requests is=20
> currently reported as 16 (WLAN_SCAN_PARAMS_MAX_SSID) when registering the=
 driver.
> The scan_req_params structure only has the capacity to hold 10 SSIDs.
> This leads to a buffer overflow which can be triggered from=20
> wpa_supplicant in userspace. When copying the SSIDs into the=20
> scan_req_params structure in the ath11k_mac_op_hw_scan route, it can=20
> overwrite the extraie pointer.
>
> Firmware supports 16 ssid * 4 bssid, for each ssid 4 bssid combo probe=20
> request will be sent, so totally 64 probe requests supported. So set=20
> both max ssid and bssid to 16 and 4 respectively. Remove the redundant=20
> macros of ssid and bssid.
>
> Tested-on : WLAN.HK.2.7.0.1-01300-QCAHKSWPL_SILICONZ-1 v1

This is not correct format:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#=
tested-on_tag

On what hardware did you test this? I can then fix the tag.

--
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
