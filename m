Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3C158BDD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 10:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBKJ2D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 04:28:03 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24633 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgBKJ2D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 04:28:03 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: wY1vGb3L6tStC306pDIM1yeuoOvzxeXFqaNl9QZQ1El+ca3TWE9PVnw6wQAtI8kb8/JMP5ch5N
 2jbbvtCvPt/dwGGlqAv92oTSCpC1yYudxRkk7wu8RViI/b1+Qo+7mHrDFiBQRsX0+4jP+c75OV
 xsL2srTuqD951fH/Eq6y6TLqPS61t+G6QZRnWAQJGKSpaRNofdvdlbxK3cFe4otENpPQ5+1fwW
 kL0t2/Uxvq+r8Bkiy73tqSEv9FyOliw8ljXHIV5oQa9hl7fNJspMSEDuk88Cc/tGY5q86uv27Y
 +os=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="64948113"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 02:28:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 02:28:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Feb 2020 02:28:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdUra4VxKZnSe8gw2q6wBp/gJTQthrf+GFGAN8wfJWlHerGfQp2PsipS44sSUGRUkfGYK/CwBT6vUji5ptaRIcjqua8eqVdJBQFuUxZgvaN4nKojaqATllm+U/gPtUmkliPIxi7GHdn0zSCUrcHpZ+6Q+hexELL+/Ez+Z5su9ndGVJE+12ODTFcYranRp1V4wcwLtJy7Gmse07V+3dGBx+5c/X8XamDvIrZ0NZEvVYXEgRRU9GlLuKlH/aqRvmDtrCJ1CErkxl64KA4d2AZaj0WxANrf/WPOlPrsccv64dYiZZHb6/TfQCXRhnHswH7prz4XKIjhxFFxpAKkEAsaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY7PYmvxEaagE/+gCFrxAiExanC15tNLLFFpGTWswlg=;
 b=NxBg5mdZLVCoLwVWuE+XP0lL8IQ1mHzaX0tjcOPwm17zWUM8rd2KjsA+Ih2doWrlFIEUc+P183qZ85jW+RhicxGc0/ibiE60rL/lVfuzZ1V25/oGESg6gqgcK0OJfOkEFiTh+Y4/6g6W4a81p7PE7nT3AWn12nSFjU5G+Mby3xWNhTFvh9Jop3mnyFKvnCO8M51Tt5nv9cNJWRcpmoiNCypeCie1wl0mh3PbkHIYum1ZLBt4bqaRBxa78XOS3Nv1XcIb7dncLsCzlOScAK85iXTUr2+vTiTo6mHgv1L2Siv3paWw0UzibAf9J9f2qUJ0v3IefLf+G+JFRnFiqhwsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY7PYmvxEaagE/+gCFrxAiExanC15tNLLFFpGTWswlg=;
 b=sP2wW/lMUKNR+y2n5Oh93ODu228C8QMpOlOt+KFj+0sa35vds1SoQUWicoSy8GYKHg4AM7WMHJ6RHpSNSuay7yQldcuSVozzhnEwWjc9qD+/kXlXqk3iPWEabXESSNcvG/+VRdkqDA36vd8jDW1xKrMU2h5DZeFaVMmKKdYWV+c=
Received: from DM6PR11MB3996.namprd11.prod.outlook.com (20.176.125.206) by
 DM6PR11MB2954.namprd11.prod.outlook.com (20.177.216.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Tue, 11 Feb 2020 09:28:00 +0000
Received: from DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392]) by DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 09:28:00 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>
Subject: Re: [PATCH 3/3] staging: wilc1000: refactor p2p action frames
 handling API's
Thread-Topic: [PATCH 3/3] staging: wilc1000: refactor p2p action frames
 handling API's
Thread-Index: AQHV4EDxsHh/P/Va7E+9rDOtcLPc66gVjryAgACIVwA=
Date:   Tue, 11 Feb 2020 09:28:00 +0000
Message-ID: <563331bc-b892-90e8-a8c2-69e9367527cd@microchip.com>
References: <20200211000652.4781-1-ajay.kathat@microchip.com>
 <20200211000652.4781-3-ajay.kathat@microchip.com>
 <20200211065101.GC1778@kadam>
In-Reply-To: <20200211065101.GC1778@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f1f3205-6181-4cd5-7caf-08d7aed4afd8
x-ms-traffictypediagnostic: DM6PR11MB2954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2954C86FD0F380DFABE4D4C0E3180@DM6PR11MB2954.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(64756008)(31686004)(66446008)(66556008)(478600001)(66476007)(6506007)(53546011)(107886003)(4326008)(71200400001)(76116006)(91956017)(8936002)(6512007)(66946007)(54906003)(5660300002)(186003)(81156014)(81166006)(316002)(8676002)(4744005)(36756003)(2906002)(2616005)(6916009)(86362001)(31696002)(6486002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB2954;H:DM6PR11MB3996.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MwBSKL++DFgdnfQ7pPkAZxBC4NQN7rls7qd7sqgZKBI6igf2dRDgCA4snEKkS01533zYDiRdk0lsQpwN2wAMKV2koKEINeImex7yMvVDieJlanYAdYALdFOndkSL4lIywpp78q6KvLDokzTw1Hd9obYJkcdMqM3SPtE3gmCblWBmpmtXetMyQkAdhprSU2reo4ucDbo9Eg6JehEbGhOHzxKbvIQpVZBEBG3hXHQlasKS1w537XzUnSk8lNAZwJspnDsu4PlTuepPQZtT9El+x6l+t+IocfOV6oQxxqTdZh7adUQErEvhdIL/oJxraIItZn7Ef6YCzbX9e06zoXIaXBGe8658zcRZPUGeH4hWJqd0ffuh82rXlfWZEWZRRf4egiVLQe4hf/q8mram+pA5+wFs6MrPgwPyZazosh2C4rNil5NYOpaarS3CdtkMbJSM
x-ms-exchange-antispam-messagedata: TY1PZORVBuvHtYbPP+pLfgq7aC8OMEr+SJE1+KlJuFSRruGoi+PeWEfVXwjJ5fl9fzGhyQmOTZ21IrxJSIosX1kCZF46nNWfaXP8S9sRO5QSqKZlOSU2R1IzSP3cDF9u4Pk0JdcS9xGXhj7wxR4f7w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9293884B59771A47AB3874C9D1C854FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1f3205-6181-4cd5-7caf-08d7aed4afd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 09:28:00.1515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsvQcox74jfXpcrOqQgL2a119G4DFc6Y8W3CqhRQ+JJt+0a8W/vdN5u1gaRvcIgYjhA9UtjjyBPE/zxeNCL0+Y8hP9VE6O/WV/92tmQ46lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2954
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuLA0KDQpPbiAxMS8wMi8yMCAxMjoyMSBwbSwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIEZlYiAxMCwg
MjAyMCBhdCAwNjozNjowMVBNICswMDAwLCBBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4gKyAgICAgaWYgKHN0YV9jaCA9PSBXSUxDX0lOVkFMSURfQ0hBTk5FTCkNCj4+ICsgICAg
ICAgICAgICAgcmV0dXJuOw0KPj4NCj4+ICAgICAgIHdoaWxlIChpbmRleCA8IGxlbikgew0KPiAN
Cj4gVGhpcyByYW5nZSBjaGVja2luZyB3YXMgdGhlcmUgaW4gdGhlIG9yaWdpbmFsIGNvZGUsIGJ1
dCBpdCdzIG5vdA0KPiBjb3JyZWN0LiAgaW5kZXggYW5kIGxlbiBhcmUgaW4gdGVybXMgb2YgYnl0
ZXMgc28gd2Uga25vdyB0aGF0IHdlIGNhbg0KPiByZWFkIG9uZSBieXRlIGZyb20gJmJ1ZltpbmRl
eF0gYnV0IHdlIGFyZSByZWFkaW5nIGEgd2lsY19hdHRyX2VudHJ5DQo+IHN0cnVjdCB3aGljaCBp
cyBsYXJnZXIgdGhhbiBhIHR5cGUuICBUaGUgc3RydWN0IGlzIGFjdHVhbGx5IGZsZXhpYmx5DQo+
IHNpemVkIHNvIHRoaXMgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gICAgICAgICB3
aGlsZSAoaW5kZXggKyBzaXplb2Yoc3RydWN0IHdpbGNfYXR0cl9lbnRyeSkgPD0gbGVuKSB7DQo+
ICAgICAgICAgICAgICAgICBlID0gKHN0cnVjdCB3aWxjX2F0dHJfZW50cnkgKikmYnVmW2luZGV4
XTsNCj4gICAgICAgICAgICAgICAgIGlmIChpbmRleCArIHNpemVvZihzdHJ1Y3Qgd2lsY19hdHRy
X2VudHJ5KSArDQo+ICAgICAgICAgICAgICAgICAgICAgbGUxNl90b19jcHUoZS0+YXR0cl9sZW4p
ID4gbGVuKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gDQoNCkFncmVlLiBJ
IHdpbGwgY29ycmVjdCB0aGUgJ3doaWxlJyBsb29wIGNvbmRpdGlvbiBhbmQgc3VibWl0IHRoZSB2
MiBwYXRjaA0Kc2VyaWVzLg0KDQpSZWdhcmRzLA0KQWpheQ==
