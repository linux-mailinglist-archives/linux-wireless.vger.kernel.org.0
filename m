Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8841E73A1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 05:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407610AbgE2D3F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 23:29:05 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:35435
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407182AbgE2D3B (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 23:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnKYHkSEKl21XaJDxpLthtoaK4WfQP4DQR3fFGf+1McnggrUYeNqyyi4JsOteqWM0xyN3keoXIA2bQ82wwdjbkN8GSZt1z1PHMRLvFT/q2sOI2KaV3F3ne0dm6XgoKSFuK7Za7xfXjIv0afOwFc/9G8TZ88tRZHsbB3CfpfCbFz7AqPJg8jB/UPql320strnJ+bbG9gRq4fy8kPfTsy54A+vgsL0wUN9j05ytqzaLq25QM5APQYFCF++2zVCfq7nR4PrqIILPc5Y/NDZSmSNBt1v3lpFBu7/JIEOrdYjWf6TVL7thjoz2II/qGzpFHSHqy8DszdJKYlm6k8hSLrlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+RJzjUhkAetnFTdjRVjHhJoF4iCdoCKShOM68Q09OY=;
 b=ZHJpWolTVaYcaH/+4wKWDbw28xyMG+EvNYrMjGbthpbMggS/o2nk59zw9aOxQQk1zpbeRgGglm9lJb3vUwLVMz2I8TpYcRiz58MPw3vBS2q1rgfBVnOwK5rJR1fEHwP9TF5L5G8flQJ+VebwSCkKgxGR2CL6kymOFHdcRxRxFgMRt+mp6Zf/MzhxVlM5R+HHB0OQ7Nk91ZqgxY8TSjc+iwXMmK+3KV6uNqG4Fk3xcB1oyxDgShLSiaXfjbkxnI0qyuC4a91HXNSdZHRx0jbHzXbI/FF5Xh+u+uLLmnKGtgjYPjyFLb+MkvTUGM445njF/0eI0SJUmZ6BhzaMR4uAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+RJzjUhkAetnFTdjRVjHhJoF4iCdoCKShOM68Q09OY=;
 b=nYjsj33H4CGjUywJyi7QoTZn+eQ6x3fG8NrVl7DjddCMRNJT7dQMZcY0qfbr5oC9ggFRCzjK6UopHFKxSeE51Xy9MtNDbHqueaQeNOj5ypbmmhQTueTOCuGgC2GWt/9JeK8Q3+kX30+MurvE0UzD84FPp3gEMHgtMGa/4oiV7ew=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB4013.eurprd04.prod.outlook.com (2603:10a6:803:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 29 May
 2020 03:28:59 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:28:59 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Subject: RE: [EXT] [PATCH 01/11] mmc: sdio: Fix macro name for Marvell device
 with ID 0x9134
Thread-Topic: [EXT] [PATCH 01/11] mmc: sdio: Fix macro name for Marvell device
 with ID 0x9134
Thread-Index: AQHWMEes5xoAaVwKSEe7FG6OYre4V6i+cY2Q
Date:   Fri, 29 May 2020 03:28:59 +0000
Message-ID: <VI1PR04MB43668C84D84103D8F8B3EA428F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200522144412.19712-1-pali@kernel.org>
 <20200522144412.19712-2-pali@kernel.org>
In-Reply-To: <20200522144412.19712-2-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10937a1e-ce0f-4459-eaae-08d803806cff
x-ms-traffictypediagnostic: VI1PR04MB4013:
x-microsoft-antispam-prvs: <VI1PR04MB40135E10FBF39F7D6C1695DF8F8F0@VI1PR04MB4013.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjYx2LyFWJrqUKMf9ZigoKm3tQeCc1+LqxbRYBDQHKAaU0ftkpDAPAg5ylwwWg2KnSzf8nF6p6PCiv1HPZWtZ/+G8qzuJZkgGLWHJy1uydZWuOhSxg6fduNn/gPlol0jJl2FFrs4Gb9KFIsQqWrytzzRQwzNDqA2yDeg9Q6BVniU/pa3GI3XlG/T7HrM2MR2ZfiiXbeh9ZZXsGjnyyg7NQB3izE64jXmFyAp80EH/yjpz2kRfQNqfYOocqPzWb/CpVqbgEN01CE6IhkgYAzAJ+9IKKCg6BXOHlnP/Cwt88WQ/WbpcaA5IsX26hWBu2el
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(76116006)(64756008)(66946007)(66556008)(66446008)(55016002)(66476007)(478600001)(33656002)(9686003)(558084003)(4326008)(52536014)(44832011)(86362001)(5660300002)(110136005)(2906002)(71200400001)(316002)(7696005)(186003)(8936002)(6506007)(8676002)(54906003)(7416002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hEHlqqKi+t+uVbuAEA4/UEzfD9RQyaWkjYD54NLf3/wdPBDeetE+Q8LwoVTcqNUTs+Pnwlah44qNo3yyB9YVgZIADoklc6WzI/+ehWqlUlxmbe2tkB9I/UgZ7RyToXqY0KV9ynA/69aQxkuXJD65W5ArL9IxXQJfOtkDDfPw/vDUt7Guewn1ARahTfooGCVJbdq+4FkMGSZwC6nFGDPNwHvYPzxxyh8rqahyHhnrN73kCedXYnAuPsCzlyfyFZZYl4iBB8uZKEwo5+d3AblQpkdmgUt9dRnjRCjD+RkovRbAhb6q2wjtyrkMsAm4kvfnxKsBAUN3UzKEh2qasx2TjAazUz1w8lbKt33GPQbObDm8CZDu9cryi5kd4BR5Wou6AyOfuu3smQs8LcIuVxnOaYJQpgvZWPxh4nXddu/vajMWFhIj9z4w2XDV1zaLHdiUeBUzO5RMa12jmBj+H3/9bmIAgY/djItDvV8oSrEjdJszdYic3qS0MVYkSHs1D4xn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10937a1e-ce0f-4459-eaae-08d803806cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 03:28:59.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /K1heXKgcg84/KQfUpVhe2RzAgBJCWLxOT60NGTL8pHtekObnEJSR48MDctHQpjl7m3bgk7AONhZdft5olnX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4013
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SEkgUGFsaSwNCg0KPiBLZXJuZWwgcXVpcmtzIGZvciBTRElPIGRldmljZXMgYXJlDQo+IG1hdGNo
ZWQgYWdhaW5zdCBkZXZpY2UgSUQgZnJvbSBTRElPIENvbW1vbiBDSVMuIFRoZXJlZm9yZSBkZXZp
Y2UgSUQgdXNlZA0KPiBpbiBxdWlyayBpcyBjb3JyZWN0LCBqdXN0IGhhcyBtaXNsZWFkaW5nIG5h
bWUuDQoNCg0KT0ssIHVuZGVyc3Rvb2QuIFRoYW5rcyBmb3IgdGhlIGNoYW5nZS4NCkFja2VkLWJ5
OiBHYW5hcGF0aGkgQmhhdCA8Z2FuYXBhdGhpLmJoYXRAbnhwLmNvbT4NCg==
