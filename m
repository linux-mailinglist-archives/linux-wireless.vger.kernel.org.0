Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C89B450C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 03:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfIQBDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 21:03:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:21484 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbfIQBDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 21:03:38 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: PgAtY5Ko4fr1QHXVKO98isEcchjOZ9dCK8e5Wcpzw+iZK9BJntn/7NPVY/Z47vWRg2EXuAuTZx
 lHqBYZt7sjTxdS76b1TWq0Eb1Zt7QX581wAZC9wVFWS6s66xVqihPrQ5VVslSdX598CsJBQm9r
 rxDhN+3Ya7BvUj154HIQwYqtc6c0xjN4AAKxtDG08smck//CeeOt4GAC8jyeF4SLT7zSOExWIh
 3AUBY4qaSDoMYS+sejPMaFKfuIIZYYd5F+3lunIvr4oGue4uKd9gpvcXcxyyGP6gByJNzkW/uo
 zZw=
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="48155773"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2019 18:03:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Sep 2019 18:03:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Sep 2019 18:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrF+jwXjOGEG7xjX6ZsvizOlMn6LuKL5SIYD5m+TKY4aByzPytLbyXOVp3WN6MXnWayNhWmuFcdygfmCW2nSlhjEr2WN33TADZX5P2P9WekOO4Jn1+Eiklh93wjoAkmjTUMOCaxCbSGnhRD0SzQokrHjJX3nj4Ja9DAe01jILchbJ56rAnaFj26wNVG4y88bM5iiAzu3GqpgLR/qzg/vlWbNpdPtlmJ330UniilGl9ECt8W/YgQ65J5/Uz7kzNrJsa6LL/8F9sZyNuqsE+MWY95zKOcPlsSIk+2Vm6NacAqyJMJBjPW9U7gSMf6rCDTnkJilsghyyY67bLOgbco5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PW79reMQJxO68Nc6BUFu2eTunb3O5D5mlwxa1AUUPE=;
 b=V9tqTsWBn96y0y1/GRSZrShV7ynfQbDOEi5aoahf68quMKvvMXA6m/bqMnxekRDwFBXDVcLmSi+X9VMpVfO51KQFb5sFMdJDwgAWkWbztfXDV3G+vCYunqTTfj7miG5/mZnJrEaAcRqujWhn862O5vBIZIgPjXE76TH2cv/wYQDR1QjCPKHxCQPnZUmtjkaFiBnpoTZEK0uP65kBGgh8ABQSIlX5d9segljvMVXOjhfV43ErB5HDmRPjo+x7y2n3DE3n/+rv5UC/VAimQovpxxPUNPlNBK+dNC9YZyVuK9MUAj8PxW9AjpraO+jJcWUF32dZhGmvCoZbXoHgBojgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PW79reMQJxO68Nc6BUFu2eTunb3O5D5mlwxa1AUUPE=;
 b=mweuD/J9PvVnmpbruo6wf5T/6rq1q1yxls0NNZ7P+iONlluIrUewmPRgyzqYZ6D6wI8qTneeTtVJ/m6Mr8lqvGrF7Qv6Bw1H/IBpvR8AMc8l2vC8ZHKx9cuOAX5ziryQgts855cw/l1hpD76y4/jGIrR6kaIq55gICNi0gGSSAE=
Received: from CY4PR11MB1366.namprd11.prod.outlook.com (10.169.255.11) by
 CY4PR11MB1638.namprd11.prod.outlook.com (10.172.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 01:03:31 +0000
Received: from CY4PR11MB1366.namprd11.prod.outlook.com
 ([fe80::78ba:f834:a390:85ae]) by CY4PR11MB1366.namprd11.prod.outlook.com
 ([fe80::78ba:f834:a390:85ae%10]) with mapi id 15.20.2263.023; Tue, 17 Sep
 2019 01:03:31 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <lkp@intel.com>
CC:     <kbuild-all@01.org>, <linux-wireless@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Topic: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Index: AQHVbMYg6jIVhd9+50ifu++xL1vFiacvCfCAgAAD7wA=
Date:   Tue, 17 Sep 2019 01:03:30 +0000
Message-ID: <4b015529-aeaa-b01f-01ce-1a81cbe2aea9@microchip.com>
References: <20190916193701.20755-1-adham.abozaeid@microchip.com>
 <201909170853.9YktTPSZ%lkp@intel.com>
In-Reply-To: <201909170853.9YktTPSZ%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
x-clientproxiedby: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To CY4PR11MB1366.namprd11.prod.outlook.com
 (2603:10b6:903:2b::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1683a9e1-1d0e-409b-2e54-08d73b0adb03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR11MB1638;
x-ms-traffictypediagnostic: CY4PR11MB1638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB16386E07BA7D1143D4360D1A8D8F0@CY4PR11MB1638.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(386003)(31686004)(64756008)(66476007)(2616005)(476003)(25786009)(6512007)(6486002)(107886003)(6246003)(305945005)(6916009)(99286004)(256004)(6436002)(65806001)(66066001)(65956001)(71190400001)(7736002)(71200400001)(66556008)(486006)(14454004)(86362001)(66946007)(53546011)(186003)(229853002)(76176011)(26005)(36756003)(6506007)(5660300002)(102836004)(558084003)(3846002)(6116002)(478600001)(66446008)(58126008)(54906003)(81166006)(81156014)(8676002)(4326008)(2906002)(446003)(52116002)(11346002)(8936002)(316002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1638;H:CY4PR11MB1366.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: odlgb1aFXXGSoYIS5PxEYx4Uu6opQpOfwSUNRp8fY8XUKQRd+VuF7M54+Ca+pGT0O/IWJksjlgMEam1HkwXjIvbX0UxMJRdE7nEu0MnM0+STzKWdOKI4/u0xOCpPSZDpOFfaQOWV2y//i+T/ZrVuedfBUFoa0nsX+Ku10C9LVVcHeLHUS0LWLamR4joUm/4+3Fh8EicrQ3/UJSVbm2WVBXdaJshy6Vf8auZ+L/VGUlhjqUMtc8pF8mHzuQSpozvYdxhgpsbVu83LGKxrbAcLOEygt83FZMnZY7Hbfx1lxV2JDLYho9dY8HwdiJNAE0qFnJ+alzU9Iy7jtlFGIqg6Fhwbe4zhwRjfnclRGpLDfUwjLJ+EjpD44WNGuyrdF7VQ7u8d9XgH14dXsj435eMmjjb00gd3oyzoeYGAw0lwYAs=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <7FCC93F281D8DD478F9818C7C3C0A3A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1683a9e1-1d0e-409b-2e54-08d73b0adb03
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 01:03:30.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04UhilA69kiY9Zqj+ks+/jLUNZ7sfzuA18SE4sYX7bXXMjCnG/PL7uQHmfPA439ro3jK/Mk5C0aWMDL7qr8A1B1cn8C6o7LkIcRuLj8qZdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1638
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/16/19 5:49 PM, kbuild test robot wrote:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3 next-20190916]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
This patch applies for staging-testing, not linus/master.

Thanks,
Adham
