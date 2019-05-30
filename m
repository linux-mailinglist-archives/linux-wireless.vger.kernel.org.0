Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4132F9ED
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 12:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfE3KBk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 06:01:40 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60800 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727671AbfE3KBk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 06:01:40 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4U9nfbR021114
        for <linux-wireless@vger.kernel.org>; Thu, 30 May 2019 03:01:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1V0CgiGH9Cx5q9TVR74o4NLbC5+nFzgT9nQocLFsf/Q=;
 b=c6jJVFH01dvBZe04svHklbAoZOx495pVLcpHpdqluHwf/VQxP+iTthroz18pQu/7Anob
 IQm0kGUTHbN3NOkqpMv3tyfn05jvCo7RQzK4+HEgXS3ZsjXW5Tlw5q6y9GeaHEZ5c8co
 1/1SfmwPeAcbi6KF0Owv7/tuqiaIIy1u6LEsExwek1+7oCH++NrbhWz8Us12i5lYkHLP
 GKDpEww1j13j3P2ciN1Y5MlMRqDvCKnIduA+MvEQf7SVr97NDm4X+K7xYYneHq2qPQpH
 cmXFiG5m6Wuq7yd1BaXbIcwGwUkJLq3PV/2x0YuG0uPUSBE6fOmUyUH8bniatUma+xHb mg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2st4489y1s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 30 May 2019 03:01:38 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 30 May
 2019 03:01:37 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 30 May 2019 03:01:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V0CgiGH9Cx5q9TVR74o4NLbC5+nFzgT9nQocLFsf/Q=;
 b=WJZ85xk23z8Qq5dOfyQkT5hCeXgpCbTTLkPp6yuW2u8o3b0u84aRVEseAeERdo45lASSHu8KkEynwImx7L7AQ1qLA613VypUPVLL3vpZ9bBSlJ3FWCJ0wdFSeciJt4lFkdFL9CY79KUS1xZPS4H91DpNOt1DxCXI4jcozYbpkIE=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3104.namprd18.prod.outlook.com (10.255.86.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 30 May 2019 10:01:36 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8%7]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 10:01:36 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>
Subject: RE: [PATCH 1/2] mwifiex: add support for host wakeup via PCIE wake#
Thread-Topic: [PATCH 1/2] mwifiex: add support for host wakeup via PCIE wake#
Thread-Index: AQHVFs12ovvWc7GpoUetU5v2gRFEBaaDbeXg
Date:   Thu, 30 May 2019 10:01:35 +0000
Message-ID: <MN2PR18MB26379DF16EADA38F72A87412A0180@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <1559209955-10089-1-git-send-email-gbhat@marvell.com>
In-Reply-To: <1559209955-10089-1-git-send-email-gbhat@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.17.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e6d4a62-acd5-428b-220c-08d6e4e5cd27
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3104;
x-ms-traffictypediagnostic: MN2PR18MB3104:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB31045FCE65AA5947AEE31E34A0180@MN2PR18MB3104.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(136003)(346002)(199004)(189003)(13464003)(486006)(478600001)(7696005)(86362001)(476003)(14444005)(6436002)(8936002)(6916009)(81156014)(53936002)(446003)(8676002)(71190400001)(76176011)(107886003)(5640700003)(14454004)(2906002)(3846002)(6246003)(6116002)(11346002)(71200400001)(256004)(2351001)(54906003)(25786009)(99286004)(4326008)(81166006)(9686003)(305945005)(68736007)(76116006)(91956017)(186003)(33656002)(66446008)(64756008)(73956011)(55016002)(66556008)(52536014)(316002)(66066001)(66476007)(26005)(66946007)(5660300002)(53546011)(7736002)(6506007)(102836004)(229853002)(6306002)(74316002)(55236004)(78486014)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3104;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 19qeAibZSFdcYAEzdDRYKNqm6f285XfJ7uSZOhtf5fDZ37TcQlS8K+maBSakMGbS29tWnQaA45vPZjTeagDPX8AE/ZDIIqZn3P9z3AFWr+StUH75/F586qypgJALDYk5N41Lrue3+/aB+/wDCoScb+TkERGcUcJXHp5barysCC72tbKeQIsvPSPepk85aarZ3FaZgatqmB1jrNwHG5def3FQG9S8wuo6fJ+CuVCEZg8cYgv0kPnXbSvXDkoqlAaY+NLTl1Yxsz3zG11T/20Aj9BxYZa/rOk0g0XUeTpn0HO5uxxebZU76HtZmxM/z1nT77EYZoKqhJr6ewo4VKJsUxWLccxj48Kr8VmcavPZvATWd3p2LAug44VlHIbb9tAb/7D5mM211K9bUpeaOA4yuqWw9xFNYDIrONv+NlipY3o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6d4a62-acd5-428b-220c-08d6e4e5cd27
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 10:01:35.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhat@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3104
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_05:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I have pushed two patches usingn 'git send-mail' and below patch is the fir=
st one;=20

I could not see the patches in patchwork page(https://patchwork.kernel.org/=
project/linux-wireless/list/); Did you get this patch?=20

Regards,
Ganapathi
> -----Original Message-----
> From: Ganapathi Bhat <gbhat@marvell.com>
> Sent: Thursday, May 30, 2019 3:23 PM
> To: linux-wireless@vger.kernel.org
> Cc: Cathy Luo <cluo@marvell.com>; Zhiyuan Yang <yangzy@marvell.com>;
> James Cao <jcao@marvell.com>; Rakesh Parmar <rakeshp@marvell.com>;
> Sharvari Harisangam <sharvari@marvell.com>; Ganapathi Bhat
> <gbhat@marvell.com>
> Subject: [PATCH 1/2] mwifiex: add support for host wakeup via PCIE wake#
>=20
> From: Sharvari Harisangam <sharvari@marvell.com>
>=20
> PCIE WAKE# is asserted by firmware, when WoWLAN conditions are
> matched. Current driver does not enable PME bit needed for WAKE#
> assertion, causing host to remain in sleep even after WoWLAN conditions a=
re
> matched. This commit fixes it by enabling wakeup (PME bit) in suspend
> handler.
>=20
> Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/pcie.c | 27 +++++++++++++++--------=
----
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c
> b/drivers/net/wireless/marvell/mwifiex/pcie.c
> index 3fe81b2..0bd81d4 100644
> --- a/drivers/net/wireless/marvell/mwifiex/pcie.c
> +++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
> @@ -147,11 +147,10 @@ static bool mwifiex_pcie_ok_to_access_hw(struct
> mwifiex_adapter *adapter)
>   * If already not suspended, this function allocates and sends a host
>   * sleep activate request to the firmware and turns off the traffic.
>   */
> -static int mwifiex_pcie_suspend(struct device *dev)
> +static int mwifiex_pcie_suspend(struct pci_dev *pdev, pm_message_t
> +state)
>  {
>  	struct mwifiex_adapter *adapter;
>  	struct pcie_service_card *card;
> -	struct pci_dev *pdev =3D to_pci_dev(dev);
>=20
>  	card =3D pci_get_drvdata(pdev);
>=20
> @@ -160,7 +159,7 @@ static int mwifiex_pcie_suspend(struct device *dev)
>=20
>  	adapter =3D card->adapter;
>  	if (!adapter) {
> -		dev_err(dev, "adapter is not valid\n");
> +		dev_err(&pdev->dev, "adapter is not valid\n");
>  		return 0;
>  	}
>=20
> @@ -181,6 +180,10 @@ static int mwifiex_pcie_suspend(struct device *dev)
>  	set_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
>  	clear_bit(MWIFIEX_IS_HS_ENABLING, &adapter->work_flags);
>=20
> +	pci_enable_wake(pdev, pci_choose_state(pdev, state), 1);
> +	pci_save_state(pdev);
> +	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> +
>  	return 0;
>  }
>=20
> @@ -192,16 +195,20 @@ static int mwifiex_pcie_suspend(struct device
> *dev)
>   * If already not resumed, this function turns on the traffic and
>   * sends a host sleep cancel request to the firmware.
>   */
> -static int mwifiex_pcie_resume(struct device *dev)
> +static int mwifiex_pcie_resume(struct pci_dev *pdev)
>  {
>  	struct mwifiex_adapter *adapter;
>  	struct pcie_service_card *card;
> -	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +	pci_enable_wake(pdev, PCI_D0, 0);
> +
>=20
>  	card =3D pci_get_drvdata(pdev);
>=20
>  	if (!card->adapter) {
> -		dev_err(dev, "adapter structure is not valid\n");
> +		dev_err(&pdev->dev, "adapter structure is not valid\n");
>  		return 0;
>  	}
>=20
> @@ -416,11 +423,6 @@ static void mwifiex_pcie_reset_done(struct pci_dev
> *pdev)
>  	.reset_done		=3D mwifiex_pcie_reset_done,
>  };
>=20
> -#ifdef CONFIG_PM_SLEEP
> -/* Power Management Hooks */
> -static SIMPLE_DEV_PM_OPS(mwifiex_pcie_pm_ops, mwifiex_pcie_suspend,
> -				mwifiex_pcie_resume);
> -#endif
>=20
>  /* PCI Device Driver */
>  static struct pci_driver __refdata mwifiex_pcie =3D { @@ -431,7 +433,8 @=
@
> static SIMPLE_DEV_PM_OPS(mwifiex_pcie_pm_ops, mwifiex_pcie_suspend,
>  	.driver   =3D {
>  		.coredump =3D mwifiex_pcie_coredump,
>  #ifdef CONFIG_PM_SLEEP
> -		.pm =3D &mwifiex_pcie_pm_ops,
> +	.suspend  =3D mwifiex_pcie_suspend,
> +	.resume   =3D mwifiex_pcie_resume,
>  #endif
>  	},
>  	.shutdown =3D mwifiex_pcie_shutdown,
> --
> 1.9.1

