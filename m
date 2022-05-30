Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E97537B09
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 15:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiE3NIs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiE3NIq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 09:08:46 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444070908
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1653916124; x=1654520924;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=61Kz+7XYiH6k8tXLpInFD4i18zv3bWc6W/lqTT8AinQ=;
  b=fL7SM5IBEHzDSOlsSsupj6iJEIwfW4Wpz4pRz3tC5leLGir2S+dTxf1N
   suPxyT4w3iFxSwg7kOfcErWeGLDXzqb1GbKda4eO2pr5CwWT4w4ZD+P1t
   mNe8HjkROwwQu59UL/WUDI6QScw5nnUiBXfz/HUE17rJuMWfdp/0b/YcS
   w=;
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 13:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn4pEb4jdo3h8q7pAKTrHtkdGTsY8gRFG42vuqhmKbQ0CkZlhZJDKRdXRjwZHMyQop5qZRGpJWfEpQUGz1pT6dr89gtq0/X0S/u3jDLXsd6rC0uy1g6Pj/K/Ch/0h8tGeZ1UjWXsJKBn/9CB3n8qayYtw8Wzmsf5nVkjgvtPReCTqA2Cyd1TA5msoy6M8FQzhWEhAdKXpMMzWhd3HoVx2/8WDlljdqLPz1SznuzzE2mcZPWNVZQuFvPt8Xqp/k8AxZithoCO/4ZEz5HDSC4qy99jVedMJHMRWi09qJBeZ0RGrgXuR1lR7MDKz+xPoc8Y96b3zh0uX5N2C+xQ3vYT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61Kz+7XYiH6k8tXLpInFD4i18zv3bWc6W/lqTT8AinQ=;
 b=JWLgSmcxgTaYPFn1Ab2z6Mmtduj82/8BjXBh/b+YmkCTWRfnP0rFpoYHZsrjB5I56wLHv4XZmr/7wfj3x5uWptM58dm1evjqW3LKp6FnU7ANND12irRoZiJ4xHeT3oxdrJ9ypexkTM0F4d0fj7tblqoHbwGLZQ0FPdSdyk8pfBCQ/4Vr9X50t7ZatZQ8iUcSyFRZvopdkkZc0cUx8ni2jN6CWYML24JGAR/Y3DGLN69YejeOzIoOy6DtTmrquIVTu7KvDawtgf1O9QyeUmCy5NH187jRIkl8sQct6WwCDAQ/ud39ToAE6O8GtHUkW+cATuCl3sTOuO3iyJfGYDUQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
Received: from BYAPR02MB4567.namprd02.prod.outlook.com (2603:10b6:a03:5f::14)
 by BYAPR02MB5493.namprd02.prod.outlook.com (2603:10b6:a03:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 13:08:40 +0000
Received: from BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::6d69:ee43:fa43:5f24]) by BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::6d69:ee43:fa43:5f24%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 13:08:40 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: [PULL linux-firmware] ath10k & ath11k firmware 20220530
Thread-Topic: [PULL linux-firmware] ath10k & ath11k firmware 20220530
Thread-Index: AQHYdCXVbEEoqRIoa0OQdS5Y1EolrQ==
Date:   Mon, 30 May 2022 13:08:39 +0000
Message-ID: <BYAPR02MB4567904C36E83634CB0ED09292DD9@BYAPR02MB4567.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 71664d7c-22b8-0d29-63d2-295fa1ea744c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qca.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7464782a-5c30-479d-8c2f-08da423d83e1
x-ms-traffictypediagnostic: BYAPR02MB5493:EE_
x-microsoft-antispam-prvs: <BYAPR02MB5493CE55054D283EDF90059B92DD9@BYAPR02MB5493.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qm4ugN8OJh8Rb/f1g5NzXriCni+87fhCHylWUKUKEakIlZcuo7FkxYxky7A9oge/3KleGBC2Q6TUIJhG7u8kC13ouCbAvcMM4xOjcLcqMwfQMsobtWlJ/em9UUTh9/clhL/SWl+qJXa1chzXCYN0S7LkMrF2NyLT1i+MbUsepFtDzKJK5Bk04+uN9+qBq/YRKNseh67Eeab7q0l2PuC0PQvPHbyAhEOBcqCgL/z5WYheTCEaQo1sm4dkPZ56bqFxnz8Icf0l9weYfQE52DAKYfycdfcB3IPByDfxQbrpLvVEbwCjqNKYo5JG3qRmTYsuSt/FLozhZNmuwV85cZz81n7WgJbgWECkqqG0oXLZrbPEikH9pdaOaKo0eLU8fYmiy1vy9/4OR6iw6kh7XIpiHNQo9wJ5Xf/FXsvLpiRnijHVDZG3uPUQ+FRg32iGOZ8voftLCY3pJmplMsOhHw8k5USpFi4Jih+xON0QvKbEal7UKDLx+xyVNKOg+26MCyPSXTXnsTS9ItBok7DmoJrfODHYA9afXZDQlB/nByzn9sPAaq7UxqtN1V4pLOvvN2D+HdF68xkrqb5xW6MrAnrBM/zmi2ROE2y25jFv6cMq+WQXjWLmw4Zs3/lnLxVa8+nQpEl6iFxnb5awfst4XKxn9gy5aVypSDtJQ7gh3zyve8wUiDUGOzZJVVycJ5Y8t2T4705xPdpVslbTxT5BM4Rt9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(83380400001)(66446008)(66476007)(4326008)(6506007)(76116006)(122000001)(52536014)(54906003)(2906002)(55016003)(66946007)(8936002)(186003)(38100700002)(9686003)(8676002)(71200400001)(7696005)(38070700005)(26005)(86362001)(508600001)(6916009)(316002)(5660300002)(91956017)(66556008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yl4h92FceXGVxE2ECwCnQOSQ3+Z/kQCoKo5PM0lNUVgtauExFaKjbBwSCI?=
 =?iso-8859-1?Q?PwB6ebqQ10BTtDijKIieVSies2/BrD5U2UgV+saSqk32h+umQ3vTvoksvY?=
 =?iso-8859-1?Q?ZRDCgOA1cgzLuInd47OvkDAveW8b0Qnf/lWo/o2hEXwO4mjNWBbHAzwMIE?=
 =?iso-8859-1?Q?/wnJ5AsuZfvCwaBFAHmqEk4Rz5hmDvbQsXxpIrJg2UP/z++yKuFM5DWBh4?=
 =?iso-8859-1?Q?BKEG26KaZ/R4Hoao+7pYn3tu76yW66ZdnSlIFfiQffsmedSm3rEKt+2s9W?=
 =?iso-8859-1?Q?9J6N1jFHj/DDXAI8ksj7Kq25wKa6enlWJY+rQCb31if8NwmIyG2d1WeMCJ?=
 =?iso-8859-1?Q?5FNapG5j/JeVhQLe4W/fAVEPCqERxobdL0MqNJDIOQiN25/dlGMUkBgx/l?=
 =?iso-8859-1?Q?SzjGj2Bel4t/Q0Hrb6b5T8BRP7R/BpdKFMyF8SueakbB6QUzGspdk8oOAj?=
 =?iso-8859-1?Q?31mX3HAf5Ou4M9WGAxuv5B1KBPV/54mRjoOAMEaVx/p3gJ5yQcWJzVBamJ?=
 =?iso-8859-1?Q?OGJssG604ZYFMB6nVZS7CnCmKsJEiXEpQYfKjAfto5yh9mHFDgp0LVpxxB?=
 =?iso-8859-1?Q?jGYUY2Y7CBfv/Owse4s2Hd25Ngee6fbjRxIKiJzxCfM55YfzqbC9gUu3tT?=
 =?iso-8859-1?Q?1KJagl4vLaB2+BcRT94TV1W7g11+gdva5PKuiCqS7dm/BVuzCXgrDpXZmx?=
 =?iso-8859-1?Q?vt+cOGx8k5sWkvd4v293ONkG6CWAaU1wscFQLXVgJ3Stgn9RowUd5B++sW?=
 =?iso-8859-1?Q?uFLzdwdF5cjezzTyJPxS+3E5psZhcaVDcRwb6dARwxQdfiNXlJfHh10mzN?=
 =?iso-8859-1?Q?QK4UMW/IfXI1Jxc0Y+KzB/Jaqvn4H0WJgEzOwoB+OGJTMBHylp9s0HYh4v?=
 =?iso-8859-1?Q?h1uR6IbGvNc5p74YBN0V4hJGG7N+V+dklS9mPCZRcMygO8xS6G+O4lsKml?=
 =?iso-8859-1?Q?M0SiG4e39TlgOWyF0omuHNgOKgjWf43JRSsmse/a+Dri//J+5ScdI+kMci?=
 =?iso-8859-1?Q?4MviweEJ/Urs0r6nnFqZG1klI/kKQRns46WdAcZSfT7IP27ping224/+MA?=
 =?iso-8859-1?Q?jIHS/rJOMua0YEB8RU1N46TSsJ2rofN5FOBnn2GB3nFxHcSTa+rGALcL80?=
 =?iso-8859-1?Q?v7hGp9RPP2WpDNLXAayat/gMURRWFwuVnqXlpn39KBnDltGE7U4l2v/RIS?=
 =?iso-8859-1?Q?s29nCVY155odiut39M5eQT24NQaRGa35FnlXedZkzm255YLfvZRnBJneCz?=
 =?iso-8859-1?Q?RrU8Ce+T2ETXtOddnVgMDwfwGc32S32+XzG1bGjlTklBRb5GnfowokfdUj?=
 =?iso-8859-1?Q?SRYC5ZYdmf/9vC9LyZx6qqRCb3xQd7UDKJRt0y1JLCmEsvyxYkNgdRU26g?=
 =?iso-8859-1?Q?qhKgTkjTjF7j17iwNmGtp04QBQfJCv9jq33ipNwe/v3qFEsM89nqmvOHIr?=
 =?iso-8859-1?Q?iBSUiLQ/qeuZi7gMCuKxid2LgN3buvpIIBqCdPVByGDC8F4hnuDw3PzVip?=
 =?iso-8859-1?Q?Xn270Q/wLb8d49v6zBiGiOdJN3SPLaKgxkw7vHPmCgAtSF85hMJ6w39P8d?=
 =?iso-8859-1?Q?J7+nLo5/RxRTr4XLPR1evXCS1Uq4Ytp0hJWgNuGIoISm4M8GOpb/O/C1Tz?=
 =?iso-8859-1?Q?nn1d3QvrPWyfsGbv9YRpnVwSlzzRDgSKYgk0r0oZg6pTP3WDsp6sHHA6VF?=
 =?iso-8859-1?Q?iRuDw4g05xau40b1BQjfbcwDsv5mYAb0wcAznbAuHtgm6ozj2yIDqHPb9D?=
 =?iso-8859-1?Q?3Iy6XG5fZ56MZ/VMV17Bhgy/Hra55PqR1iZr+WNSgS9JwVdvtAEmQ6uJni?=
 =?iso-8859-1?Q?T3Vj065mEg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qca.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4567.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7464782a-5c30-479d-8c2f-08da423d83e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 13:08:39.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z1nALptiT03MoXg1hVq2w17QRplZJnaZ2PZhEYFqQ1c+yc2s1y6eXU+Wu9ESKUmS4y9k2LpZy6VkfwriyR4Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5493
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,=0A=
=0A=
Here's a new pull request for ath10k and ath11k. Here I'm adding a missing =
board file for=0A=
WCN3990, otherwise just regular firmware and board file updates.=0A=
=0A=
Please let me know if there are any problems.=0A=
=0A=
Kalle=0A=
=0A=
The following changes since commit 251d29004ffce3462779dbd08073a2cd8dfd2087=
:=0A=
=0A=
  amdgpu: update beige goby firmware for 22.10 (2022-05-16 15:25:38 -0400)=
=0A=
=0A=
are available in the Git repository at:=0A=
=0A=
  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git at=
h10k-20220530=0A=
=0A=
for you to fetch changes up to 82b0ef7166e2b7f9d12e7745a2af4e4c75c1aea8:=0A=
=0A=
  ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILI=
CONZ_LITE-3.6510.9 (2022-05-30 16:01:56 +0300)=0A=
=0A=
----------------------------------------------------------------=0A=
Kalle Valo (7):=0A=
      ath10k: WCN3990 hw1.0: add board-2.bin=0A=
      ath10k: QCA4019 hw1.0: update board-2.bin=0A=
      ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00157=0A=
      ath10k: QCA9888 hw2.0: update board-2.bin=0A=
      ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00157=0A=
      WHENCE: ath11k: move regdb.bin before board-2.bin=0A=
      ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_=
SILICONZ_LITE-3.6510.9=0A=
=0A=
 WHENCE                              |  11 ++++++-----=0A=
 ath10k/QCA4019/hw1.0/board-2.bin    | Bin 1129788 -> 1154076 bytes=0A=
 ath10k/QCA9888/hw2.0/board-2.bin    | Bin 133540 -> 145684 bytes=0A=
 ath10k/QCA9888/hw2.0/firmware-5.bin | Bin 693604 -> 693700 bytes=0A=
 ath10k/QCA9984/hw1.0/firmware-5.bin | Bin 681568 -> 681672 bytes=0A=
 ath10k/WCN3990/hw1.0/board-2.bin    | Bin 0 -> 461060 bytes=0A=
 ath11k/WCN6855/hw2.0/amss.bin       | Bin 4972544 -> 4972544 bytes=0A=
 7 files changed, 6 insertions(+), 5 deletions(-)=0A=
 create mode 100644 ath10k/WCN3990/hw1.0/board-2.bin=0A=
