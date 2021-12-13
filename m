Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F34723C6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhLMJ1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 04:27:06 -0500
Received: from alln-iport-3.cisco.com ([173.37.142.90]:5103 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhLMJ1F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 04:27:05 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 04:27:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3958; q=dns/txt; s=iport;
  t=1639387625; x=1640597225;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=c7O5EJd7QZuVLxge+g9no7XW4gKwxq1J+Rp1pBeBir8=;
  b=YrWq0Z18ji+k/S+V/3GkuHmy3eACro1IaWvf6CQ9KbMu3l4+8vKfoN8h
   l+/Y9sVFfWqOx+XP99mOkJWYaV+RHXItU9zw+bU+gjDuQOaPBhJf0qrZ7
   Nb/R66hj/VBDXvLxFNJh05zEbIRvRT1GYRa/I5rKUsYDvxhFz3R8xy+0I
   E=;
X-IPAS-Result: =?us-ascii?q?A0B+BwBED7dh/4oNJK1agQmBWYFSJi4HeFo3MYRHg0cDh?=
 =?us-ascii?q?TmFDoMCmxyBLoElA1QLAQEBDQEBNwoEAQGEBoEAAheDCwIlNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQYEgQkThWgBDIZCAQIBARQREQwBATcBEQEZA?=
 =?us-ascii?q?wECAwImAgQwFQgKBAoEBQgaglCCZQMvAQ6kOgGBOgKKH3qBMYEBO4FNAQEGB?=
 =?us-ascii?q?ASBNgEDAw0DGCaDABiCNQMGgRAqgw6EHoJhG4QxHIFJRIEUAUN5gT5ugmMBA?=
 =?us-ascii?q?gGBQCAVD4JyN4IukipPYQMQGiyYL6ljCoNAimOUYxWDb6NhliwfgiOKO0STK?=
 =?us-ascii?q?oU1AgQCBAUCDgEBBoFhO4FZcBWDJFEZD5ISgX+IX3QCNgIGAQoBAQMJkHABA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:8bE8HxF4bgdXqflxTicez51GfiYY04WdBeZdwpYkircbdKOl8tyiO
 UHE/vxigRfPWpmT8PNLjefa8sWCEWwN6JqMqjYOJZpLURJWhcAfhQd1BsmDBAXyJ+LraCpvG
 sNEWRdl8ni3PFITFtz5YgjZo2a56ngZHRCsXTc=
IronPort-Data: A9a23:6yT0R6CCa8qu9xVW/5Dhw5YqxClBgxIJ4kV8jS/XYbTApDwh1GdUz
 zMZC2jVb/2DYjTyftF0b9m09R8H6pSAnNNnOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /3z7rAsFehsJpPmjk/F3oPJ8D8shclkepKmULSdY3ooHlc+IMscoUsLd9AR09YAbeeRW2thi
 fuqyyEIEAb4s9LcGjt8B5Or8HuDjtyr0N8rlgBWicRwgbPrvyJ94KTzik2GByCQroF8RoZWT
 gtYpV2z1juxExwFUrtJnltnG6EHaua6AOSAtpZZc4yl3F9EtCpx7r46avkyREZ2l3aMgd8kn
 b2htbToIesoFqTInOJYWB5CHmQje6ZH47TAZ3O4tKR/zWWfLCCqmKsoVRpwZNZIkgp0KTkmG
 fgwISsQahGer+m327m8DOJrg6zPKeG7ZN9H4ikxk2ux4fAOc6ruRf7rtMdh2j43u81PRunbe
 9dIQG86BPjHS1gVUrsNM7o6neG1ljzgcidVrF+OvoIp7GXJig98yr7gNJzSYNPibdpUhEucq
 3ndun70DR0QHNie0iaetHOqiPXGkS7yVMQVDrLQ3uVkh0eIxmEeIB4bT122pb++kEHWZj5EA
 0UQ/ixrpq8o+Qn2CNL8RBa/5nWDu3bwRuZtLgHz0ynVooK83upTLjFsouJpADD+iPILeA==
IronPort-HdrOrdr: A9a23:Sweo+KvXUuMu0Lv6vLEYxT2i7skC0oMji2hC6mlwRA09TyXGra
 GTdaUguyMc1gx/ZJh5o6H8BEGBKUmskqKceeEqTPmftXrdyReVxeZZnMrfKlzbamLDH4tmtZ
 uIHJIOc+EYYWIK6PoSgzPIU+rIouP3ipxA7N22pxwGIG0aCNAD0+4TMHf8LqQCfng/OXNPLu
 vk2iMonUvFRV0nKuCAQlUVVenKoNPG0Lj8ZwQdOhIh4A6SyRu19b/TCXGjr1QjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y+FEGNeHhqEuW3fRY0eTFcFcso+5zXcISdKUmRAXeR
 730k4d1vFImjfsl6eO0EPQMkfboW0TAjTZuCClaDPY0LLErXQBepB8bUYzSGqE16Lm1+sMjZ
 6jlljpx6a+R3n77VXAzsmNWBdwmkWup30+1eYVknxESIMbLKRctIoF4SpuYd099Q/Bmcga+d
 NVfYrhDTdtACenRmGcunMqzM2nX3w1EBvDSk8eutaN2zwTmHxi1UMXyMEWg39FrfsGOtV5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCMXPQrJz85qkz+YiRCdE15Yp3nI
 6EXEJTtGY0dU6rAcqS3IdT+hSIW2m5VSSF8LAW23G4gMyLeFPGC1zwdLkeqbrWnxxEOLypZx
 +aAuMiP8Pe
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,202,1635206400"; 
   d="scan'208,223";a="804000962"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 13 Dec 2021 09:19:52 +0000
Received: from mail.cisco.com (xbe-aln-004.cisco.com [173.36.7.19])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 1BD9Jqni015285
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Dec 2021 09:19:52 GMT
Received: from xfe-rcd-005.cisco.com (173.37.227.253) by xbe-aln-004.cisco.com
 (173.36.7.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 13 Dec
 2021 03:19:52 -0600
Received: from xfe-rtp-002.cisco.com (64.101.210.232) by xfe-rcd-005.cisco.com
 (173.37.227.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 13 Dec
 2021 03:19:51 -0600
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (64.101.32.56) by
 xfe-rtp-002.cisco.com (64.101.210.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14
 via Frontend Transport; Mon, 13 Dec 2021 04:19:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2SsCE+hMti2y/x/C0P1Q3JGT4vN4rOm8EiwxkMSxzDAD1+LJKug162mfnMIzmQrMurQxlqU3iZnzWV8lxca+VaBZftQunFS8Sw8AEMhY5eFsD8krr03BLxOtCFtmeBHxLLx+fck4tppn7KEDTQzBDV/JG2PYOGLLyXxe+2EXNhx7pP42PIrQRSChNJTDGfvBkBlVWi7UB4qK3XyB7lE087OhurGxfYY202DuSJpSZBnfV5PSNOHleh/R+OwFDCD1NALuF3Ly3QHSUfVLbbdKsj2gQu/8nMiWk5tmHLTbhJMksuQn7FSVCgnL4aC33fuLAVR6toW+VbjB5TRbxTz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7O5EJd7QZuVLxge+g9no7XW4gKwxq1J+Rp1pBeBir8=;
 b=WhNm4xnH5Eu/Q3F45K6+4j5rX3Q3JBhsoUeuhkMYN45P/YeQoKb7DdQONE+QCe7ngDyT1dlNtv4GziX374lWqtpQ9/99kIUDc75Y1N/rp6wHs/KGZ6k+KfRIXuEwn3XqVcsJIvTxB7hMuxKMXET9TCwsJYeRi/iaSqXdXssxkgGILY03so6Ze4DkwSW5Lv2BXyu9T5gGpCQHb9FmEoCrqa7jpDBRmgf5Ls+cEibE1fqOaUgSoonFBbquyY6iYMGtCRvHAVvydzHZF2ruvJz3MPisWmSPuSzuDttKpyJsITRpUC08+Gu9wsuuxGyaUcYahpVbDWgfKT9LAJTO90vgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7O5EJd7QZuVLxge+g9no7XW4gKwxq1J+Rp1pBeBir8=;
 b=a/FwAs03g1w5a4FQ5bLmkGExWRe7HJ2rPVf1FCBjZUcApKUJiEqLr3I78rTFUNWsVniBbZRe4ZErPG8v+3/qn6xN1ig2eSAFXNbH6QV7RB3ge67YbzoSvUS/53fXs/hPwaRGn4O58pSlrfbeW1z5gTrOouI3mmEtMcT53N5/bRc=
Received: from DM6PR11MB3116.namprd11.prod.outlook.com (2603:10b6:5:6b::29) by
 DM5PR11MB1866.namprd11.prod.outlook.com (2603:10b6:3:10a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Mon, 13 Dec 2021 09:19:50 +0000
Received: from DM6PR11MB3116.namprd11.prod.outlook.com
 ([fe80::11c4:1451:dbd7:8f58]) by DM6PR11MB3116.namprd11.prod.outlook.com
 ([fe80::11c4:1451:dbd7:8f58%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:19:50 +0000
From:   "Asura Liu (asuliu)" <asuliu@cisco.com>
To:     "sforshee@kernel.org" <sforshee@kernel.org>
CC:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: wireless-regdb: Update regulatory rules for the US on 6 GHz band
Thread-Topic: wireless-regdb: Update regulatory rules for the US on 6 GHz band
Thread-Index: AQHX8AD8P9/krwzi6EuMqbudT2TmuQ==
Date:   Mon, 13 Dec 2021 09:19:50 +0000
Message-ID: <DM6PR11MB3116340921B7E66B0E4176A1D7749@DM6PR11MB3116.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.55.21111400
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa2776ee-8995-4ad2-5acf-08d9be19b6e1
x-ms-traffictypediagnostic: DM5PR11MB1866:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1866EDD1D2FA20043AF43CCED7749@DM5PR11MB1866.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pa2RonOqvIX4uB6VMVbT83MotIauIaioQfrhxL8v565nTVPnAU3tpdOKFGe3wba6BetbYY9Mo3Zb+12l3RqKEzLDpZqSMOyN3rBhcVLTEEsYHOfC/GkZ6g+XkJ2hqC1yT9PcNs6bpZMr0+4YXnEOt7LBzfNzeFt0G+Dm5U78dD3k6nLvBFvu4dDldEm+Jhj28bZ1IgEJBHzO75FTnIS0aEZnwjomx+aRAZs+R7il25SzOgIL9lEDKr62GmiXISGurd472n2zbS/D+d1bZl7nxIBKwFOLN/out66MFdyKdgwY5nSxGke8WHLRc7HlFqqbmYL+pj/ApW8JTY4xceVBSM3MLLPmBxQJ90uwhNSAWv49Y/OjhFZvMqW0dKWKruDaR4746RrdBvHct0AgNEZWdAurkcjkMdLDtZYA+LphffED0J0aqsSxyY9eLFqyHyRAnv58Z6X3o8SwwtSC3VOAmFs/yODjw+czRGN8X1TRVmezhlqrXmZAALsHX2xkFe1tbLcli9qTRp/JTkroGB5m/YJ4qwuEHIG0xiILlXZKxTxBMYFT3R3oXx40KC8+XCFqr9X47ZTzgQZJEPSqCu7DwASy112VjwJA0bcHkZsy90xQCTke+DPKLl3Pyp0sijL5E4Rt3sq8vqSSmZdWDb4H8XcEHv/CUZbzTIE82X6AE9PevuDH5vLxV7TXVUDNIQ3qonrNID4UWMlmsAqS4tMkIi4oc1Dn5b6E0ReSJ49Penqa2TjeM+R66NqsSlVSYiZ7Ey4GHfTWP6oGykJ6C+Q33+/7+Ac5KfyBLZsn3UuAY2vNTWitsI1NvKU6RXM3sYyq4kJ4+MPS/fdljshWQCpzeS+CCxmtHCzrZRHxqtDdpjQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3116.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(8676002)(64756008)(6506007)(33656002)(52536014)(9686003)(76116006)(66946007)(966005)(53546011)(122000001)(508600001)(91956017)(38100700002)(5660300002)(8936002)(66556008)(7696005)(38070700005)(66476007)(316002)(6916009)(71200400001)(54906003)(86362001)(4326008)(15650500001)(55016003)(2906002)(186003)(83380400001)(46800400005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UklQWVpUOFAvNVYzUHRBWFNtTmx1d2dQTVRNeUR6M0oxdytaMENFRXVHbEdR?=
 =?utf-8?B?RUc4Rk1wOFVlK2FiYzB5UVoyNnhGMjQyMjBQRitLRDNrdDZJczNRcDliblNj?=
 =?utf-8?B?ZXg4QTZtTkVDcWk0T2VsRzR1V3JWWEV5aVFFSXc2OVdrZVNSckhBaTFKcWNo?=
 =?utf-8?B?N1c0eEdZU1dQWXUwcVFkd2RKdlhFR2pBdUwxMnVmUSsxL0dkeExWU3Ixc1BK?=
 =?utf-8?B?Sk5JWmVqaHJLZGxhRjl6VzJrQStoakc5Y1BtSFJ2OWNiUjB2Q2RRbjV1Y3Mx?=
 =?utf-8?B?ZFc5Y3dxalZ5WjF5aVlxTmJpOHlTQTZKOEkrZGsrYnVSaHN3cmZsaWlmMHc1?=
 =?utf-8?B?OWsycjJZWldkbDFYK3BrcjJBeSttK0hDUVpNVW9HTmIxeGF0d2RtcUl4NDB5?=
 =?utf-8?B?OC9sZWFYMlZ5cGtCalJDZjljMURDeEVzZlhzOE9VVGhxWVpzTHdVZUIyVXVP?=
 =?utf-8?B?akJkZTFVK00zYUFIWjlCZmdEVDhGc1JDRDlQNXFXNklMcnpMYVhwY0M2alo2?=
 =?utf-8?B?RDdiTUs1OWh6dTViZlQ5UEtJaHNISFZLbTUxS1l5K1VqcmdKWkZQVUE2Z1RE?=
 =?utf-8?B?UDdhZXF5NGtnNDFVU010dGhKeUV5aGxXL0tvYTVrYmIzRFBKQzBPTXd1WmpF?=
 =?utf-8?B?NmMrWnpXOUFyVTZycXFUdWRkRkFGOVV5NTlYL2VzNld0Z09VU2NoRE90THlo?=
 =?utf-8?B?a3c4UEo2Sis5VjA3ektUTFdNUklLVUpuT3E2WWp5bW5jalV4V294RUlzMDRE?=
 =?utf-8?B?SEx4Y0pURlVZT0x0NVhFcWszMU52MWdXckM5dnFKZHcvWFA0YmZmQXJuWGJ4?=
 =?utf-8?B?MHF6VWt0MmQ2bk9XNi9pUCtLdGo1ekFnWlFBMklEdEYxZTZGUWtaMEhYOTFQ?=
 =?utf-8?B?RlhnNCs2d25DR2Y2MGF0bjlHUFJtSGdNdlpZVTM2NkxFUThOam5qSy94eUpk?=
 =?utf-8?B?dVNjWFhGbnF1TVZ5YlZOZ3FzQ3ZrNXRsVjBtV29HbmZYaVpNSGVhcXZDZ3c2?=
 =?utf-8?B?VjlmRzlsOG9vL1J2cW1TMDg2VVlUbWxUemppNXpQek0yZ05VYzZxeE9zNlNy?=
 =?utf-8?B?RmlGNXh3T1k2K09EbGhDZHRLUjNlQUpoYVhXeVhCUGxxRStNR0FWc1g2SFEw?=
 =?utf-8?B?QXpkSjdtaTlCWnUrNVBhTWI0OEFNTWdrUEM2K29ZVmtIbnk0bm4xSU1mTDRi?=
 =?utf-8?B?Y0FvUUZlbGJGL0s5VGh1TzVMWmVNSVNwSTM2aktFdTMyYU41TTBVNGpUZnJ0?=
 =?utf-8?B?dWlLTkg2Ui9lTmhvRi9MeVNVTGpFa29vVEYzVXlvSThUNkJjYVZyQWJONFgz?=
 =?utf-8?B?eWpwb2RVTmRZSm92UTV2djBzclZjSTUzbmdCUHZVaUJDSW52ZHhuY3Y5djFC?=
 =?utf-8?B?Qzlnc3NSMEprQm9nY2wwenIvb3d1eEJGeWtHWWF3bUtreUlRdUVrL0ZTSklD?=
 =?utf-8?B?UE1CTWlQYmJrSEMyeGtwVERzb3ZPUUZ4bXoxbTRQaDFHaGNHSXNRMkFLWm0v?=
 =?utf-8?B?UzRac0F6UGw3azM0VEdDcE5yQzdYMEdxVVNpMGxZZFArRWo4WjkrdERaWUZu?=
 =?utf-8?B?eXJRTml6SC94WHJ3ZllXMHM1Nmt6a3dtSWVNWUQvV0V0bE02YW1iZ1BFRith?=
 =?utf-8?B?L2ZMMDg5VmRSV1hDOC9BVmZpejdHTU1wZjVzM0Q3eGRyWkR5d2lWQ3FKcEtU?=
 =?utf-8?B?M283MVloc1dqMVJORDlWS0krNitBaVZ3WGQzTWY0T1E4Tllub1dvUjFoNVly?=
 =?utf-8?B?SVFYdGN3RnZJMnFtaktBYVBpcG96Y2ovKzdUaHFjelhsK0c5S0dIYTZBYlU5?=
 =?utf-8?B?Nk9QLzlUUkhNVHlqblR1SXhKbHhLS1BET3pQVTlMbml5aUtuUVNQUWtQQUtO?=
 =?utf-8?B?WExoNDZubmhPNURoUjNMTk4vYS9vczNVN3F6ODFEaldFcEs1eVJNWEtUeVhh?=
 =?utf-8?B?TGl1dU5FY0d3dHkrVGhaM3k1Tk5XQWZIUlFNYkZuUWlTZGhIRDZWNVNzSG1M?=
 =?utf-8?B?NnQ3WGhDN2JKakdiR0hsZnBqRGsyM0ExRk1xM0FoaDdTZHVuTjhOcy9qdDNT?=
 =?utf-8?B?djRnSGJ5N2FXVzVrTDFuS0NJZnN2NU5zMEdNRVQ4bUl2YzhzMHpseS9YM0ZX?=
 =?utf-8?B?NWN4RERWd0dQRGl4d1VZYkRoZjNRL2tkb0VsUlAxaDNrMmF2dUxwTkdOVTdm?=
 =?utf-8?B?a3ZoVk53N0dCRXFvSHZLZnZDVnZqbXd2ZHlaa0xxRXh1OEhPdFk1NzNrelFq?=
 =?utf-8?Q?6dgFPgNmM2h5fg8loMIyM+zNRkfrZjmF0Emctv2LMY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D4F3AE8C17AFF4799D57C3F816BB2FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2776ee-8995-4ad2-5acf-08d9be19b6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 09:19:50.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcFRqbtZPnQGndN3yatwufMgi0BZkbw7e3fNufbLYG8xlwxag52l+bTFwE+cFrNSipw/7ZObV883CS8wp1hCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1866
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.19, xbe-aln-004.cisco.com
X-Outbound-Node: alln-core-5.cisco.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbSAzZGIyNWVhNjc0MjMyZmVhNmE1ZWZjYTI5MmY2ZWQzZmQ4ZWJhN2EyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogQXN1cmEgTGl1IDxhc3VsaXVAY2lzY28uY29tPg0KRGF0ZTog
TW9uLCAxMyBEZWMgMjAyMSAxNjo0NjoyOCArMDgwMA0KU3ViamVjdDogW1BBVENIXSB3aXJlbGVz
cy1yZWdkYjogVXBkYXRlIHJlZ3VsYXRvcnkgcnVsZXMgZm9yIHRoZSBVUyBvbiA2IEdIeg0KYmFu
ZA0KTUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1V
VEYtOA0KQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdA0KDQpBY2NvcmRpbmcgdG8gRkND
IDIwLTUxLCBGQ0MgYWRvcHRzIHJ1bGVzIHRvIHVubGljZW5zZWQgdXNlIG9mIHRoZSA2IEdIeiBi
YW5kOg0KIjU5LiBUaGlyZCwgdGhlIENvbW1pc3Npb24gbGltaXRzIHRoZSBsb3ctcG93ZXIgaW5k
b29yIGFjY2VzcyBwb2ludHMgdG8gbG93ZXIgcG93ZXIgbGV2ZWxzIHRoYW4gdGhlIHN0YW5kYXJk
LXBvd2VyIGFjY2VzcyBwb2ludHMgdGhhdCBvcGVyYXRlIHVuZGVyIHRoZSBjb250cm9sIG9mIGFu
IEFGQy4gQ29uc2lzdGVudCB3aXRoIHRoZSBDb21taXNzaW9uJ3MgYXBwcm9hY2ggZm9yIHRoZSBl
eGlzdGluZyBVLU5JSSBiYW5kcywgdGhlIENvbW1pc3Npb24gc3BlY2lmaWVzIGJvdGggYSBtYXhp
bXVtIHBvd2VyIHNwZWN0cmFsIGRlbnNpdHkgYW5kIGFuIGFic29sdXRlIG1heGltdW0gdHJhbnNt
aXQgcG93ZXIsIGJvdGggaW4gdGVybXMgb2YgRUlSUC4gU3BlY2lmaWNhbGx5LCB0aGUgQ29tbWlz
c2lvbiBhbGxvd3MgYSBtYXhpbXVtIHJhZGlhdGVkIHBvd2VyIHNwZWN0cmFsIGRlbnNpdHkgb2Yg
NSBkQm0gcGVyIDEgbWVnYWhlcnR6IGFuZCBhbiBhYnNvbHV0ZSBtYXhpbXVtIHJhZGlhdGVkIGNo
YW5uZWwgcG93ZXIgb2YgMzAgZEJtIGZvciB0aGUgbWF4aW11bSBwZXJtaXR0ZWQgMzIwLW1lZ2Fo
ZXJ0eiBjaGFubmVsIChvciAyNyBkQm0gZm9yIGEgMTYwLW1lZ2FoZXJ0eiBjaGFubmVsKS4gSW4g
YWRkaXRpb24sIHRvIGVuc3VyZSB0aGF0IGNsaWVudCBkZXZpY2VzIHJlbWFpbiBpbiBjbG9zZSBw
cm94aW1pdHkgdG8gdGhlIGluZG9vciBhY2Nlc3MgcG9pbnRzLCB0aGUgQ29tbWlzc2lvbiBsaW1p
dHMgdGhlaXIgUFNEIGFuZCBtYXhpbXVtIHRyYW5zbWl0IHBvd2VyIHRvIDYgZEIgYmVsb3cgdGhl
IHBvd2VyIHBlcm1pdHRlZCBmb3IgdGhlIGFjY2VzcyBwb2ludHMuIg0KU2VlIGh0dHBzOi8vd3d3
LmZlZGVyYWxyZWdpc3Rlci5nb3YvZG9jdW1lbnRzLzIwMjAvMDUvMjYvMjAyMC0xMTIzNi91bmxp
Y2Vuc2VkLXVzZS1vZi10aGUtNi1naHotYmFuZA0KDQpBbmQgNDcgQ0ZSIMKnIDE1LjQwNyBkZXNj
cmliZSB0aGlzIGFzIGZvbGxvd2luZzoNCihhKSAoNSkgRm9yIGFuIGluZG9vciBhY2Nlc3MgcG9p
bnQgb3BlcmF0aW5nIGluIHRoZSA1LjkyNS03LjEyNSBHSHogYmFuZCwgdGhlIG1heGltdW0gcG93
ZXIgc3BlY3RyYWwgZGVuc2l0eSBtdXN0IG5vdCBleGNlZWQgNSBkQm0gZS5pLnIucC4gaW4gYW55
IDEtbWVnYWhlcnR6IGJhbmQuIEluIGFkZGl0aW9uLCB0aGUgbWF4aW11bSBlLmkuci5wLiBvdmVy
IHRoZSBmcmVxdWVuY3kgYmFuZCBvZiBvcGVyYXRpb24gbXVzdCBub3QgZXhjZWVkIDMwIGRCbS4N
CihhKSAoOCkgRm9yIGNsaWVudCBkZXZpY2VzIG9wZXJhdGluZyB1bmRlciB0aGUgY29udHJvbCBv
ZiBhbiBpbmRvb3IgYWNjZXNzIHBvaW50IGluIHRoZSA1LjkyNS03LjEyNSBHSHogYmFuZHMsIHRo
ZSBtYXhpbXVtIHBvd2VyIHNwZWN0cmFsIGRlbnNpdHkgbXVzdCBub3QgZXhjZWVkIOKIkjEgZEJt
IGUuaS5yLnAuIGluIGFueSAxLW1lZ2FoZXJ0eiBiYW5kLCBhbmQgdGhlIG1heGltdW0gZS5pLnIu
cC4gb3ZlciB0aGUgZnJlcXVlbmN5IGJhbmQgb2Ygb3BlcmF0aW9uIG11c3Qgbm90IGV4Y2VlZCAy
NCBkQm0uDQotLS0NCmRiLnR4dCB8IDYgKysrKysrDQoxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kYi50eHQgYi9kYi50eHQNCmluZGV4IGI4OTg3OTkuLmM2
ZWY5YjYgMTAwNjQ0DQotLS0gYS9kYi50eHQNCisrKyBiL2RiLnR4dA0KQEAgLTE2MDYsNiArMTYw
NiwxMiBAQCBjb3VudHJ5IFVTOiBERlMtRkNDDQoJIyBodHRwczovL3d3dy5mZWRlcmFscmVnaXN0
ZXIuZ292L2RvY3VtZW50cy8yMDIxLzA1LzAzLzIwMjEtMDg4MDIvdXNlLW9mLXRoZS01ODUwLTU5
MjUtZ2h6LWJhbmQNCgkjIG1heC4gMzMgZEJtIEFQIEAgMjBNSHosIDM2IGRCbSBBUCBAIDQwTWh6
KywgNiBkQiBsZXNzIGZvciBjbGllbnRzDQoJKDU4NTAgLSA1ODk1IEAgNDApLCAoMjcpLCBOTy1P
VVRET09SLCBBVVRPLUJXLCBOTy1JUg0KKwkjIDZnaHogYmFuZA0KKwkjIGh0dHBzOi8vd3d3LmZl
ZGVyYWxyZWdpc3Rlci5nb3YvZG9jdW1lbnRzLzIwMjAvMDUvMjYvMjAyMC0xMTIzNi91bmxpY2Vu
c2VkLXVzZS1vZi10aGUtNi1naHotYmFuZA0KKwkjIGh0dHBzOi8vZG9jcy5mY2MuZ292L3B1Ymxp
Yy9hdHRhY2htZW50cy9GQ0MtMjAtNTFBMV9SY2QucGRmDQorCSMgbWF4LiAzMCBkQm0gQVAgQCAz
MjBNSHosIDI3IGRCbSBBUCBAIDE2ME1IeiwgNiBkQiBsZXNzIGZvciBjbGllbnRzDQorCSg1OTI1
IC0gNzEyNSBAIDMyMCksICgzMCksIE5PLU9VVERPT1IsIEFVVE8tQlcNCisJKDU5MjUgLSA3MTI1
IEAgMzIwKSwgKDI0KSwgTk8tT1VURE9PUiwgQVVUTy1CVywgTk8tSVINCgkjIDYwZyBiYW5kDQoJ
IyByZWZlcmVuY2U6IHNlY3Rpb24gSVYtRCBodHRwczovL2RvY3MuZmNjLmdvdi9wdWJsaWMvYXR0
YWNobWVudHMvRkNDLTE2LTg5QTEucGRmDQoJIyBjaGFubmVscyAxLTYgRUlSUD00MGRCbSg0M2RC
bSBwZWFrKQ0KLS0gDQoyLjMwLjEgKEFwcGxlIEdpdC0xMzApDQoNCg==
