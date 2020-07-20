Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38675225A15
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 10:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGTIdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 04:33:15 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43153 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595233994; x=1626769994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+7gZQryFplDiuMXNLD/M11ByxFkrOl4vd7gL1EbCGR8=;
  b=d3lm389vTc9rHT3hJQph71pVUicj1g0z30Pg3VFrRURGnMpDEizL3b4H
   GSL6oNqKywDp0w70DwkW3U+1tKi6eNkQsZO9QFeMtyt2bM7mK5Z7/VY8F
   p2tYWH41UYoWyG04m3Krv4nBOoweXB5zSnNlngU3l/MeSMW87Ypojj/cT
   DggbmtNBMS047KWY8afe5UI4ry343U6hAUJxYWj9OVbwMpyOkUOrKVqQQ
   88Ti0VY31A1M9r1Z3I7c1Ax5wgIg9J0UQOXWcz8aNdeftLCOVeCAnKK03
   a4xFKOiPLTr22XfjmlNrHFj3YUYFQ5hSacSXMFKYYbC3GErBG6mXyn61a
   w==;
IronPort-SDR: wUErtyOKTdONHMK1iBP087vdGQDAAMKFIueCLCtoXzFrfEA3aHSBLrIqFrmFehpR82mXDp3Yh2
 T2KwPSk7H3ZrXnqshEJVTk1TqpHCfKj3rx/dbY7sre75E3o6cfMlyYtBoF73UkWA7iRr5pflYH
 ePJbJdoPrLr4+anX9P5hwKytaOYdfLyD+JOjLAzyb5qk/2rgZBOnPSxDCttzjKsgNFEmNBUVns
 eU4U5GYScN3U5FZ0QA6wKKBXncNs+rA3z4ue3B5RS3ThuScSwK94M8Iioc0OnAGavGmEG+qcVM
 QzU=
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="84575923"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2020 01:33:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 20 Jul 2020 01:33:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 20 Jul 2020 01:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksSa8tNClFVKvX1OPP87aVVbn5e1w7YElvo5/fQodfvGyUpvDCMskc6woQC6/zPYfFyXx5BLeDCs3X6DhlUv4DZpp+0oyQ5Dej31lBkGfQYNXmCaDZy4Yw9g5kJxBqEbUOpMYU2CSGvkmPWazzcLXGTCOYO+JVALO8xKv2ZkM4A3emwsVGVD0x0h/CSwsP+w0/1hDY9bXDhh5fy+nOPS0cJtPrzlvPE9KDWnuvwFcipV2g5oFElenUW9NTOl1X4FJXzdJ/5a+epIC0WtJLgyuXA33Wj0T0oV2o6qrPrC5XQrD9EmcW2EMz3zII1oVrHbJ9jyNH2B4FDurTqgANuXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYY4Exx7NgOXXHVyS6bcIFOqMW/sjPGTy2h3vkFn22M=;
 b=oIefLUErya0w8tpqmRtBjjOBG0vq1RDbopoPD40o8dNJNwdC/YKYG7CX1MKWYX/t1ZmzDu2QM6pakxBFaVh/igze5VRRHLx47IZDzmnbOvPDPRMntOrhWFUTzamAASeMOSD+HH2fj4+QcEsm9okcvbBG8uxMYoO8aC2wogfzmC0rej3LPmIoZIKqTZJ1mnRZtNSPnQ5EIIBuODVPbJobXFfrQSo7QjnbspGen3jafKWEoa/OBnnaOBnDjQry3D5/ELuvHjb5NHhO8g0bhpcBUnuCsCeTjk+RtfH6ip5G4Tzw/7CWjV85irE6WR1RbMjV86V8S/H3FEliGcfjXmZcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYY4Exx7NgOXXHVyS6bcIFOqMW/sjPGTy2h3vkFn22M=;
 b=XJnwsAaV0YyALTlx2sgS9xbHc5Ox+6wv9SWohbPdilhaZ5Nu1vNF6Q7bFVj7g2aG7S7u0zSO5InqF1QvK0KqJC4jbXnVg8pp7YSM7z3y19MFsKgAEeT0KZQ+mBDBOVtrYVGRqmBR8r7I2yxAZ5LYQ5jTcDm6JOIOLMV0LvuV7Co=
Received: from MWHPR11MB0061.namprd11.prod.outlook.com (2603:10b6:301:65::37)
 by MWHPR11MB1341.namprd11.prod.outlook.com (2603:10b6:300:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:33:12 +0000
Received: from MWHPR11MB0061.namprd11.prod.outlook.com
 ([fe80::c907:e7ec:bf95:f0be]) by MWHPR11MB0061.namprd11.prod.outlook.com
 ([fe80::c907:e7ec:bf95:f0be%4]) with mapi id 15.20.3195.024; Mon, 20 Jul 2020
 08:33:12 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <kvalo@codeaurora.org>, <sfr@canb.auug.org.au>
CC:     <vkoul@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <Ajay.Kathat@microchip.com>,
        <vladimir.oltean@nxp.com>, <davem@davemloft.net>,
        <alexandre.belloni@bootlin.com>
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 wireless-drivers-next and Linus' trees
Thread-Topic: linux-next: manual merge of the dmaengine tree with the
 wireless-drivers-next and Linus' trees
Thread-Index: AQHWXnBn5imCi5Rt602FuZ1dt9J6tA==
Date:   Mon, 20 Jul 2020 08:33:12 +0000
Message-ID: <5bc97453-15fa-b855-0d5a-886fcfb5e0df@microchip.com>
References: <20200717165336.312dcf09@canb.auug.org.au>
 <87tuy673e9.fsf@codeaurora.org>
In-Reply-To: <87tuy673e9.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3e273dc-60b0-4e3e-0656-08d82c878a42
x-ms-traffictypediagnostic: MWHPR11MB1341:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB13416FF4C2A70343F48D3B4AE07B0@MWHPR11MB1341.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: toqguEIEMx+k59LGhmV8i7pUBMYmiWW1/TWC9dOvwck7OnIlWHG2/tl6haheckxShK9NRpghjEEFQzqt3dldGUzUDg8NKIocLaJo9sWWcteAijit+28oW5SHcUcp/2GRurz1EXCHfkBgjUfblQlWKaC5MH9tb8ulc5wXnL9Kqnpovot4J7d6sXIajgOfS4x8VQ7Cb0Qa1ICBzUUsoM/11W1ABGfk++EyHm+lsk01qtqCQlYlyv/+xQiEcc5usiTaMCLDprNUzcMPWKH8UJSJFRynL4Rq59yUV7qyznCqdvIB5zUIr0N4rCm3iwjVTNaQyWk9RcLyOqKHUtngvS+MJWY5SToL+1j7lG5+3pjDJmQTyrSR0FOB3EcjrfvOnffB/o2whlqnz9dxSjRxv0BF7wB934VL/cIPD+GizMwFRMebos57+ROADkYXeCMcAvubO9gv/y6/+U6WLt/kxlKyUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0061.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(396003)(366004)(346002)(136003)(66946007)(2616005)(4744005)(966005)(64756008)(66476007)(76116006)(91956017)(66556008)(86362001)(2906002)(66446008)(6486002)(36756003)(6512007)(8676002)(31696002)(8936002)(26005)(186003)(53546011)(6506007)(31686004)(54906003)(110136005)(71200400001)(5660300002)(4326008)(316002)(478600001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hyBqSq/I0dAEgtXNHzKjM4ef6a93AXjWXQqKtHdUSdbC3Vb4ya6aH3ftMNejOkNwaenqZ2YZPzd1esjgxVrJ+nNXbHyKRm0whHu+ni9o2rDiH1x5UnDMyrrjNI97fqWT0q4irM8HpRErIOrgb8yhaPYpJowgV9Kpo3sM/GnGcNscFcbb1rMatczFjLRSEjrx6o0XkAJzR4lxgM5kUPP4shRLwiDuDXe3EAik/fA72m/ejbC+P4Ht4xfodKKa82kZhm4No9KBRGbhUN2F7YeBSJnY2qfp1bzWc7agxseZRyc5qBWh/4AfmDgBmFP/NO4CLXGB/aqsAQJmRIk621om52yXTe5nalcthIDn29+0977n+naC3TX2ZmevSnUHfnbkqLC5QYJCu/GRBrpa5KeEVXjc2n4e8dKvsZXab1vvnkE59poRAP+MKJQ0DZqkZQ0hQaasMkzEgvkIEsARJbFfv6cDECx5CpXrmGbDilypW40=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1753B72608AA1444B537757B266D5C85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0061.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e273dc-60b0-4e3e-0656-08d82c878a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:33:12.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq9ECiZqjgwK4S1QP24244FRsHrLN90QvAwxty3zqjEd5OqPoxS1DFNKjxe3gBwNppYyd69FoR/h5+SW/575fTjCO523vaGVpd1+VIXzRH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1341
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/07/2020 at 14:05, Kalle Valo wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
>> Today's linux-next merge of the dmaengine tree got a conflict in:
>>
>>    MAINTAINERS
>>
>> between commit:
>>
>>    5625f965d764 ("wilc1000: move wilc driver out of staging")
>>
>> from the wireless-drivers-next tree, commit:
>>
>>    6e701c299469 ("MAINTAINERS: merge entries for felix and ocelot driver=
s")
>>
>> from Linus' tree and commit:
>>
>>    c3846c4cce15 ("MAINTAINERS: dmaengine: Microchip: add Tudor Ambarus
>> as co-maintainer")
>>
>> from the dmaengine tree.
>=20
> I think this is trivial enough that Linus can take care of it without
> any extra actions. Thanks for the report.

 From my perspective your resolution Stephen is good.

Thanks to both of you for the heads-up.

Best regards,
   Nicolas

> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20


--=20
Nicolas Ferre
