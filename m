Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA49F87F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 05:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfH1DCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 23:02:05 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:2776 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbfH1DCF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 23:02:05 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7S2xwjX007994;
        Tue, 27 Aug 2019 20:01:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Ey0NRysNzwU6Mia71FJEWJdZOtybuuDC3ydOmJG93Aw=;
 b=ZbkpsHrzNR+Dff5WcP3HYX8ExX3x6T6q65tnLorg7q85hipKvYdwPTA/9L2udKsDWf/7
 ckcdRzdEJAGCMZVf8SA2yRQcvg7/UXkaGXdrsSGY7v9c4MqiI0r181jNzC5ewMiSU0yQ
 L+XqiRSMnwtNj40jjywWVzeuR1b7ZaVP93xxjRFsWJ8lgEErjsu3bjaqxBhxM4hQrXFG
 WRqvRyoFNrPUqVV3AibySaPp47Kfg5X082ZKigejyo+hWH8d/GHMHwOakaWvnsE5aa6f
 Fu4UwJYrB/z10TWKaatne79P7R/XoDPZzd51yzUzKXYpbylaaeSDo/oaRbYigi7LP5Pl Pw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkn94h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 20:01:42 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 27 Aug
 2019 20:01:40 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 27 Aug 2019 20:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmCOiXEMUfFcO+u00xYUZhGIIAbQRDkXe0lVMGLrnqE8jMONpHoHRK5+XTkomWyvAnthglpEseA0qirJA55WNK/ngZTh+VcgSpozQoWMywe0PIRti1l/HfAdW00LIcdD5xCLbs9rUe/a1HGaetsryXo1zsEIr6SMwVvlrYEFuZJipefQ/deDAsaHQggysPeuDN9LRRw9h0vHIUiMlWeDBhpwezcHMqFCJGdGl4nFI8E0mwOUqKDcEgX1jBsNco0dskPCIRzzJTJQJVS5rJMyLm2eLnE2MEpDbAWbKTvO/Pcp98m+/7ljUKZgjOOPhdFJEV2a/HX+C00363fYK/qelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey0NRysNzwU6Mia71FJEWJdZOtybuuDC3ydOmJG93Aw=;
 b=U4Wf6UwKgF5NmkNjv4LGT+org4BVrkuJg1oWIPXc5gg/1yVZWhhxqewtviMaMYqVF5GDHVwn4SIHPgs7LI40xtHLy1px1lvy5ldcbE6tVGuFpbs//tjBo51xPY0RxCT/MdDWYmBb/7D4w+swl2vSdHvofTUk9EgH1w3eB7ugdBP9kP1pPWJH5Z0r55lF428XJe//NZaT6ORMFos9hIJSzLzi1spdtYidoCOWDwzEiuFR8yZr95Oi4uMcF+ECEXOAzr9r98yQDguwPNIB1sCp96ZbWS/a5N3ZiMiux18Ecf/hwTcK79O4iBCgRAmZgNbWVIvQI47bxVguRB2rEivXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey0NRysNzwU6Mia71FJEWJdZOtybuuDC3ydOmJG93Aw=;
 b=yAB6B/DruLlz8DX59AsfffHMr6B4fAstoL6tTXyzAkCa3BnEPfAeihGPkOwcWmC14BtxdPes5W7VZHz+aEBZQGgHmAg0lrk4HUTmv8RBMDZqWKXb+QbWkoguqB9gngRsW3Pzh7+X8zFBkATkHxNe9lZsSrmsY2HUXeySJiXLDcc=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB2896.namprd18.prod.outlook.com (20.179.22.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 03:01:38 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3481:568:55fe:62ec]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3481:568:55fe:62ec%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 03:01:38 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     "huangwenabc@gmail.com" <huangwenabc@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "nishants@marvell.com" <nishants@marvell.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "solar@openwall.com" <solar@openwall.com>,
        "greg@kroah.com" <greg@kroah.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "mrehak@redhat.com" <mrehak@redhat.com>
Subject: RE: [EXT] [PATCH] mwifiex: Fix three heap overflow at parsing element
 in cfg80211_ap_settings
Thread-Topic: [EXT] [PATCH] mwifiex: Fix three heap overflow at parsing
 element in cfg80211_ap_settings
Thread-Index: AQHVXUWH8kpzok00pk6ZjWgg7XgLU6cP3uxg
Date:   Wed, 28 Aug 2019 03:01:38 +0000
Message-ID: <MN2PR18MB2637246460C7C23764751498A0A30@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <20190828020751.13625-1-huangwenabc@gmail.com>
In-Reply-To: <20190828020751.13625-1-huangwenabc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.193.208.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 415d298d-6dc0-49a8-e04d-08d72b640ba7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2896;
x-ms-traffictypediagnostic: MN2PR18MB2896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2896963B645374A648E2AD17A0A30@MN2PR18MB2896.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(51914003)(6436002)(486006)(81166006)(55016002)(4326008)(2501003)(9686003)(476003)(11346002)(26005)(86362001)(446003)(53936002)(186003)(8676002)(6246003)(316002)(8936002)(76176011)(6116002)(7696005)(25786009)(99286004)(102836004)(6506007)(229853002)(110136005)(71200400001)(54906003)(5660300002)(2906002)(76116006)(14444005)(256004)(66556008)(66446008)(64756008)(66476007)(71190400001)(4744005)(66946007)(52536014)(3846002)(81156014)(478600001)(305945005)(66066001)(74316002)(33656002)(14454004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2896;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C79IhTymsQl9x9k8wswuMbE7zeAZSK2olPYio8Nx2JaBsKDfi4VYaA0kF+aGhXOvcGDCk0W7OGPnnlmQ6lamgcb8EJdyMCTGf0+3lvOs50mWnfOQzTOmQMg18V68ivZfkZKb8RsuZyTMc+x7KDSqFwiM7S8sauHHLOO9IMMIKhpjz4e3UYayLDbhLN/0/mesKkAd85V72A3u7iis/m4d9B9aj40pyUGnsuwAtS9N62PG5/r9W7SQTniATzDRkF6rLofXIVuYxxG+t7EGzGb1hRDtO2ZNu7QNEYJz6Fd84yM6NyeBrNIX+ySSIXQrTTq6oQpKzfhLfcgNZp0VVwEKyiIigy/xTZwZgwqbML0IwifYwqodYQvQ3LXF0H5NHFvLWiOgvgSyk/+j1p/AqnHdMwtr2NoIIr86ZDIr/aEZinQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 415d298d-6dc0-49a8-e04d-08d72b640ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 03:01:38.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RopOxJXnD1gUddCu0TkZKxa/ZEjwm7WUOtwCUGffQnVcNGywXWY1or7Q5P/s5L2IaeXlCLZRhhdV6bABiZjHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2896
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_05:2019-08-27,2019-08-27 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Wen Huang,

> mwifiex_update_vs_ie(),mwifiex_set_uap_rates() and
> mwifiex_set_wmm_params() call memcpy() without checking the destination
> size.Since the source is given from user-space, this may trigger a heap b=
uffer
> overflow.
>=20
> Fix them by putting the length check before performing memcpy().
>=20
> This fix addresses CVE-2019-14814,CVE-2019-14815,CVE-2019-14816.

Thanks for the fix, this change looks good;

Acked-by: Ganapathi Bhat <gbhat@marvell.comg>

Regards,
Ganapathi
