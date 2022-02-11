Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2DA4B2859
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351081AbiBKOxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 09:53:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiBKOxJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 09:53:09 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A4131
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 06:53:07 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BEq0jd020856;
        Fri, 11 Feb 2022 14:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=PPS06212021;
 bh=4fYfHuz+c1RjmXo6i0QcGQPE2HOM8tBP1dRRaKmai9Q=;
 b=NS8aOi5dPbNMBhSCDr5+Ee/9oQEop/L63Chx6MVfMeyDpSb9PRIIpkGqzSSAQC2Kha8G
 aTDfP2rwngiSzBJuh6l3Jh3RZ6GoL7F7Q7slpNoOrC65rV7OB1wjq50tH3+GS2IdZbNw
 NatuQrYz7su0Ne8IO3PgFinmhCo93okF9oTDwnFu6bWMgFmsRiiJ8HScNNrNVMV4+3tO
 QXehJM6zBm4fk+DtwmZI5qfjlkSuozRMLWkLPjH32Z0jlBPqr/Gk0MtmsSxgoIBxJylB
 Lwa/IUOFRI9cr9avuCItFsxr5QPaHelkIUe5YQapYDQ2ygsFClC3DFXPk/dAQq/Zd5Cy Tg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e4fyvsusy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 14:52:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFtRT2gjTcwM+Y9yWajfnsMlr8lUPWn3vpGmsQnHU5Zro+ZI5WuNjNJ9wS4ttu/17+U/RKpe8jVjtv+U6+xLN5+jA41fJuQw1L62XJjXwHU6PmFCYPSIk2YwMlI1yn0qcPP4/S4SMgPWyiP9BXwNLx86lFOjuWAGD7ERS2BPZI06UQDtCnYj0HnyNw59luNPhSMmXuQlpiuMxiLommLQqsBe6Ay6pbWKgBXchpBtoP7pSP8knee90mbYKWfS8Cz2Fp3PoJhwkqmrvL8PPIqa1FxWOW6Oia8gUe8W7z6TSZ9Bp9WnFslOJQl4hnN9j/3F8ZbmVYKlbaNQSEMQgR6dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fYfHuz+c1RjmXo6i0QcGQPE2HOM8tBP1dRRaKmai9Q=;
 b=nnAmcqiH8sVSmTDJSruQUqU/nlVGQz6rBwbBcj/tPaD9FL1+0soweQMC7ih8FZBsi19Cr8/cuKpa35wUrP5CfDQuX1HXCRrOEsvW/R/DLjUsVFSGnHtQW6NzjbNa+GsIWxbp6a3qGBnh5jAi7l1akFkNWZTUdRx2aDwV3t9L3WXZEA3/lZzQ5V/XK4M8tfXp9kBJirHGB7K82sidfbj8HROJDIPAbH58FKqIRcQD4QPMc8Lkm3JYxmsAeel+OlVmMSsvp+/mnVnJsy0IV8N2xG+MuEZ1Jr4SN4DT5VHsojUzg8UR9bSPxNqyJ9xYzH8dn//ARn/zJGywE37nx7QaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8)
 by BN6PR11MB1907.namprd11.prod.outlook.com (2603:10b6:404:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 14:52:43 +0000
Received: from PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::7062:2a50:3478:8dc6]) by PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::7062:2a50:3478:8dc6%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 14:52:43 +0000
From:   "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To:     "luca@coelho.fi" <luca@coelho.fi>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "luciano.coelho@intel.com" <luciano.coelho@intel.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 07/10] iwlwifi: fix leaks/bad data after failed firmware
 load
Thread-Topic: Re: [PATCH 07/10] iwlwifi: fix leaks/bad data after failed
 firmware load
Thread-Index: AdgfVauCp5wZfrvxQ1Cb/o71sZvmVA==
Date:   Fri, 11 Feb 2022 14:52:43 +0000
Message-ID: <PH0PR11MB51755AE791AC9BBE5B97DCF9E5309@PH0PR11MB5175.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e88cf55-21cf-4081-4da3-08d9ed6e28d1
x-ms-traffictypediagnostic: BN6PR11MB1907:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1907BAE96C2D4B2FAB0D1603E5309@BN6PR11MB1907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkGoV75RO4r8y+5WEMQHk0/op5dKIotA71fzlgrZqqFM2mZ6MfoDuzqYvD9I3Me42NehGiplfhXy57Q+UAsTFsOksmEwOncH61CR72b8I/rkT0g3SYni9A5+9bnWzqucTpDPfLuerQsGo8KfswTebXZcx9CJ9SKJ2WI7zWmtdxuc+hWFzdPr3PwfjkWu8XNBi8pz10c4pj4DQS2CqE6UuHlf8z4jHR8gKQHQlrlCNwpJMfCZFTDk7JtLuXKsBNBaLRDAP6y62o0LAbVwo9IvCC9wQpoQOZPQ9N97WRuKfr5BrjbfunCS3lSayazfphrP0+hK4yXpalDNCuFDYAjWi7mIaDeOw1j54vSlwZdWj0TwCTLm6WYdmyv+d/pOcqMvKsyUCcE7sx0j1tu6b997TdVKw6OlPDuejx14KT/OrWCm/thcz/hyhkb1FTuL0AmuzsaQ7bIZb3WsMwQVTINttuOtT36RThIAl1c1xelABGZ7yxi72e6cfR2eYxZtLQhW7vgq63LqXM4W3mx2C8mEWAfRCxGtzK3BMa6SIJmIaYvq3aakXniQMfdzovOSgJewTPG0zKgHdYSaN9hR4Pr55kTZnJnd2mC4shhdySsdTUsXf7ikfAd+izD5JcSzGKEFaYE2fFL/6pLvM7Ga+KW2VCsBKlAg25cfy96OduYWvrpPVKIssFHB3EWyex23IAao20akePCnDe/KIjdq4qsMGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5175.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(55016003)(86362001)(38100700002)(9686003)(508600001)(83380400001)(5660300002)(66446008)(4326008)(110136005)(54906003)(122000001)(66946007)(52536014)(316002)(71200400001)(66476007)(26005)(76116006)(33656002)(66556008)(2906002)(8676002)(38070700005)(64756008)(6506007)(8936002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VGOfGYIeEGzSRMC8k0yVADeVBlVVdMxRPHh0gVga747+2bu+6sCdv5KR1OIe?=
 =?us-ascii?Q?YNl2v5C54hIOov4ZjXNjkmiqjJsUaqoT0wEBj3j5wXW5V9qGFDOuj272QF17?=
 =?us-ascii?Q?xCJDozq4VHZSYb7EarrvupBIQJeRIzwE4HMbiWA8Qb0FQ3MbAl2ilmAa9QvQ?=
 =?us-ascii?Q?0uYog8yAWtlGLZVg83K40C0O983gf63eKcoAuVmpXqnUv3yZV3IamAWdar8H?=
 =?us-ascii?Q?LYEXGwqjfWGeWw7vu23zc04BBkPK+LbGKnBopeQiz+LoyKCWxWUjNP1BhKAW?=
 =?us-ascii?Q?HaBNuVfxr0BUGVphWvUBhd/iErU8vRbHASziHfoG5JNTvXfkfqdAz4lSCng2?=
 =?us-ascii?Q?mv+IKo+I+civl/kNWQPQW5DTLvxurLi9AKNtrxyXArTbHFrpcpWVVQjwv+JD?=
 =?us-ascii?Q?O1dIZz8ZZ+uE0+pILwXXR6vC+MzeQs9Va/9Nh3/bhhKqkPCTjyQTbslzVJLA?=
 =?us-ascii?Q?MH+asOf0cYLF8vN4/pDeqFikgxHbTgGYXbxTU9h56u88uhF5RGGPZARcBLTq?=
 =?us-ascii?Q?J/DvrVUAwEtgdFQD6Cvfe8LOuhaqNEQlRa/htNlv2sl6RWDTHWSyGUVCMD5G?=
 =?us-ascii?Q?4uJrPu/ALN+H+ghojk462ib7l4upYJ8wV5b6W/f1tluVTlpI5gxdmSrlrI3J?=
 =?us-ascii?Q?ygZBvvGMliKIR2PBxuy/O/FpnzAIGlhMr5wQ2TIzcS8kOWp4sKbSCLKiVK0c?=
 =?us-ascii?Q?co3YD0Eqh14qi18Boy6zQxLmgNDSPauA6qOLy2R3/TylL/gj2em+uv7R887v?=
 =?us-ascii?Q?TvyZEPgt8EBENR+tmUfiQLjnpfaohneUlvF0Q1O19a27raOvtSbThnAGM6HO?=
 =?us-ascii?Q?zDZtn/UFRfTosN0blvNiprrvMVsCfjEW3I9zADh+GuEnebFZQtF8kfpZ0bJX?=
 =?us-ascii?Q?h5Z/D34t7kTQoE7f7r/PJIXLJDD96WuheGBau8kztaZ94Y92tVv5PnEIdzfw?=
 =?us-ascii?Q?0PIWfzm+bRwsQS+Tco0gHWLGOxNbu2qXS4ObLgBwBICC26e/nUPvfZ4DJuJh?=
 =?us-ascii?Q?iNJxakxLAqwI6mMGHTcGJr0inrOorKycIBoGiMIlajtCfcDpi15AzNl4BAXc?=
 =?us-ascii?Q?6XDbxRmn9W8rxCSRaj909VFdckLs3qZv+jXPKYomqUahag2BzRSM5kufVTk0?=
 =?us-ascii?Q?x5TM93tkSCyAAnISnVXRc/w/NvZnALVRQ9HN+WujVOt4QY7Jqe0sC35YbnO5?=
 =?us-ascii?Q?MWt90vYs+SAq3pSEF7wWWeaz1g3Bjpy1NdPS4mrxiztY/kQ89Dm+QwWzHcQr?=
 =?us-ascii?Q?T4ODwRz0XHO4O+0BkiEwYSS6uV8eRpuqr6Ic3vGb07NJLIMNub1lsOWeT/35?=
 =?us-ascii?Q?Tc8lkx/t7WlEtDpJ/it4avA5t1klZ/gOVFdETpvi0pkUpqJ2iI+ApxpE0CXt?=
 =?us-ascii?Q?KmT52UjEdUNfnuenfdHxIN6BRd5IJw4+zf/uy/1Qz0nlaebZYkIQ/w960w+c?=
 =?us-ascii?Q?zpmLKXTl9YPjBopkqA8hfJ8MLHgXxrsDYxD6fRCenwx5zorXyXog5GNmu4jE?=
 =?us-ascii?Q?X0wBtFz5k8CfTPrhlEoPJWJ3nAokNCY18CexgCASH442YdlKAgWshKyTKw7s?=
 =?us-ascii?Q?QZ30TWH3IR++qsuvIzPta6t5LMteCxYFLZzBHjJ3CP9EmoLxRWa7HXJpK1hg?=
 =?us-ascii?Q?y5Y+9mouHA0da2uNLdKEGWeWAPgQX2mCkmdR1tUwoEaUcDxa5Sf0fTifk1CV?=
 =?us-ascii?Q?HBp2rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5175.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e88cf55-21cf-4081-4da3-08d9ed6e28d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 14:52:43.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8om+eypF3lHGPLERG6649RVuUtUCYRV8E4X+0800TqKV6SozI+LalrpXnVM8D2zyivkXanDRhUu4iuyYTOGSEGgmyIenjJHlkrLhUT51Gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1907
X-Proofpoint-GUID: QLSAp7vHM4IIpwya3bp5-pC4meQIw8Wp
X-Proofpoint-ORIG-GUID: QLSAp7vHM4IIpwya3bp5-pC4meQIw8Wp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=701 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

If there is no suitable firmware found (no firmware loaded), this patch wil=
l cause the following general protection fault.
Please help to check.

  Intel(R) Wireless WiFi driver for Linux
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-36.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-35.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-34.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-33.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-32.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-31.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-30.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-29.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-28.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-27.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-26.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-25.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-24.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-23.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8265-22.ucode fail=
ed with error -2
  iwlwifi 0000:01:00.0: no suitable firmware found!
  iwlwifi 0000:01:00.0: minimum version required: iwlwifi-8265-22
  iwlwifi 0000:01:00.0: maximum version supported: iwlwifi-8265-36
  iwlwifi 0000:01:00.0: check git://git.kernel.org/pub/scm/linux/kernel/git=
/firmware/linux-firmware.git
  general protection fault, probably for non-canonical address 0xd8fdf3bf00=
1008: 0000 [#1] PREEMPT SMP PTI
  CPU: 3 PID: 48 Comm: kworker/3:1 Not tainted 5.17.0-rc3 #3
  Hardware name: Intel Corporation NUC7i5DNKE/NUC7i5DNB, BIOS DNKBLi5v.86A.=
0074.2021.0716.1950 07/16/2021
  Workqueue: events request_firmware_work_func
  RIP: 0010:kfree+0x6a/0x410
  Code: 0f 82 b5 03 00 00 48 c7 c0 00 00 00 80 48 2b 05 4c 59 65 01 48 8b 1=
5 35 59 65 01 4d 8d 24 07 49 c1 ec 0c 49 c1 e4 06 49 01 d4 <49> 8b 44 24 08=
 48 8d 70 ff a8 01 4c 0f 45 e6 49 8b 04 24 f6 c4 02
  RSP: 0018:ffffaa8cc0247cb0 EFLAGS: 00010207
  RAX: 0000676040000000 RBX: 36415f5f0004000f RCX: 0000000000000000
  RDX: fffff6d8c0000000 RSI: ffffffffc071342b RDI: 36415f5f0004000f
  RBP: ffffaa8cc0247ce8 R08: 0000000000000000 R09: ffffaa8cc0247b80
  R10: 0000000000000000 R11: 0000000000000171 R12: 00d8fdf3bf001000
  R13: ffff98a043b04000 R14: ffff98a047f1d800 R15: 36415f5f8004000f
  FS:  0000000000000000(0000) GS:ffff98a1a5d80000(0000) knlGS:0000000000000=
000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f2e28bb2738 CR3: 000000022880a002 CR4: 00000000003706e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   iwl_dealloc_ucode+0x3b/0x100 [iwlwifi]
   iwl_req_fw_callback+0x379/0x25e0 [iwlwifi]
   ? __dev_printk+0x52/0x6c
   ? _request_firmware+0x3f1/0x560
   request_firmware_work_func+0x51/0xa0
   process_one_work+0x1d2/0x3d0
   ? rescuer_thread+0x350/0x350
   worker_thread+0x50/0x3e0
   ? rescuer_thread+0x350/0x350
   kthread+0xfc/0x120
   ? kthread_complete_and_exit+0x20/0x20
   ret_from_fork+0x22/0x30
   </TASK>


Thanks,
Yongxin
