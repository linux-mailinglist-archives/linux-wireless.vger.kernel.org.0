Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802454BD757
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 08:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbiBUHMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 02:12:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbiBUHMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 02:12:46 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FF2AE8
        for <linux-wireless@vger.kernel.org>; Sun, 20 Feb 2022 23:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1645427542; x=1646032342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/DP0+OH2EAMN17YJ06ASTp86dfvT+8X/2AAS/nBgwkc=;
  b=g01BCnEoxoLadpiVxiiPf610oQSB87kytIsje/lHiD/rcqWEFRa4niLI
   q3id4VYAFOwenA1fUf57iph7Us884Is8PC8AWR2f2f5FYadFvmGXNfsVV
   A+StJIqroYn9KZ2FRRTsp+3fXE3vSJbxpesyP1II5xuvcHtKdGrk+RjeF
   c=;
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 07:12:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKyRHbiR+JN7bS/DvEHWk3yLz3eGwnJRS5MZHdecnLfTeQltMLrjIA+SqIaLDlyIF2ysPliVsmyvCmttQgEQeJcaD08jxC8J8zLefSvW1/Eg4lqgetCbE0Mku47NPf6YsWSjUxdUxOU60VNBandvUWRif3blo7XOdluwnI4DpXd0nLC3yzfaFugjRIPapZOPfmx2jW24KnqhH/DotKTIj7YkyIVHRepcue4EmpMVAOpP0QY7ivgLIPrILWh25mkh2ykov3uJ+sPvwW0ZupyvgbQK6L42M0Xr7pEXt6BR768otd2Ye7GZu5QIIHsBg5Eq5NJG3ZltAdquSjYnypvgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DP0+OH2EAMN17YJ06ASTp86dfvT+8X/2AAS/nBgwkc=;
 b=FbC2G98WTD6DW+rUK9jGxtfeYt10Va4rUoLDHAMYhYcIb9yoRbJKDIZW2jdj9FcA0ZqsJJ3eG6V6146k9zh3LD7a+JyYZX6Gg7h5kDlUXtk1iVf0A87mjII/TQ0OVPYpwaUBmgbLM8w6INxtz9P6zVrmYdhJnBpNMB8BnGL6iyfpeyynB+cPRvaE/3wfGBhDgGh/LW5vQhaqC3tb0a5aBzcto9gTNzmYe2qbhJz6zgRUjJvN02iwy1rA4EsUvdGJ/zvacoufmCc10jLcjeptDGOju5nyccim6z6VaK3TxmTlK2NkL2809jqAmn1cuauqVF6LVaoWweNyn/zLbxeiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
Received: from BYAPR02MB4567.namprd02.prod.outlook.com (2603:10b6:a03:5f::14)
 by BN6PR02MB2834.namprd02.prod.outlook.com (2603:10b6:404:fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 07:12:17 +0000
Received: from BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::74bf:e292:9cae:e50]) by BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::74bf:e292:9cae:e50%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 07:12:17 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     Christian Lamparter <chunkeey@gmail.com>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Subject: Re: [PATCH v1 1/5] ath10k: QCA4019 hw1.0: update board-2.bin
Thread-Topic: [PATCH v1 1/5] ath10k: QCA4019 hw1.0: update board-2.bin
Thread-Index: AQHYJe1n3cf+4zLnOke+jvOFv1Ig6qydmH/q
Date:   Mon, 21 Feb 2022 07:12:17 +0000
Message-ID: <BYAPR02MB4567F6658A66149A7C184740923A9@BYAPR02MB4567.namprd02.prod.outlook.com>
References: <542cdfe3a91a19cba63c98cb742e63d4b58240d9.1645315229.git.chunkeey@gmail.com>
In-Reply-To: <542cdfe3a91a19cba63c98cb742e63d4b58240d9.1645315229.git.chunkeey@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: fd310407-f931-1d40-733a-4bcb5718c484
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qca.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0de04ca6-a676-42a3-9ff7-08d9f5097e72
x-ms-traffictypediagnostic: BN6PR02MB2834:EE_
x-microsoft-antispam-prvs: <BN6PR02MB2834F176DA49FAFA6D476BE5923A9@BN6PR02MB2834.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8J48K1USlBMR1ZH2xHxQdQiYRGIJV6o6U28NiW+iM4GSTugwAGO99jkXtYLYP15lh/MZ8dVh+mDriUiodaHk2uAqYG5pTSUY2n0/FfP0sLVxOI9xWEdAnFA3tnnRmUxpsCaYBoLcrVIFBNLYLfoCPbMgLnsQCpu302OpVVal0/xWeOtI94H71P/vC5QiD4sDCG4d4uodFQr9FPjR6on0QW9GPP1XQ/qRCa3R+ACSLC0EJCFQQgmGpNf/cp41gsl1qD+BEDW79Dy5tQWZUZwtAyH4piFkyhQO75f12RO+huagzu0rgBKSAs+/p5thMHpcIqTjzRMHF7XWV4ArEUA9tyKRDmfz+KqHg85U2AqAnOuIfw1W2LiiJMo6VFlCPyekEHV+ZOkl8eDYmqAKdxX9W6PqcOrHEaSI/P4O+XHuJWPJc/hpmH5rguhFYaK722/R6TzlEx3qbA61jqgwt2IgdEVXDaKfXg+aZ+52cDgcKiSKc0fOngJJkk7zNYBV7IbiNPLSd92fDsqhkCkkARH4HiojgguAffxHeboDFFelqLnUo+RC0wQ1nJLVTNTpJZPGJrP81KPcujFu7kEMktBQunHhMK0oYNrAipU5o0snfCzMEO5/lVX0BzsCNC2fkjio1SmiCUVrkEsITRN+RY1IVDk0b1J8gmtapaeHpsndyRpdqSp6N1K/InKp9kjwDMVaQgPnB4vXCKsrVqymcMlam7lLrIYlaCIh5KXOJZ6vl4xtByU0UF8HrdwYaCVfYP4tluhTbmNmXiEP9FK43K96algj9yP2kXGI6cukNVvxp18=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(7696005)(6506007)(45080400002)(64756008)(508600001)(76116006)(15650500001)(66946007)(5660300002)(4326008)(26005)(186003)(316002)(66556008)(66476007)(66446008)(91956017)(6916009)(71200400001)(83380400001)(52536014)(8676002)(33656002)(8936002)(38100700002)(55016003)(2906002)(122000001)(53546011)(54906003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WCEXGkqkMl9ZNe6Is4WA+IARCFqIqB7Hfr3OZeM2mRDvv/0cNEWUiV2RHswc?=
 =?us-ascii?Q?klNB3bfkISDAwoV8MHgq8POqHSjqCP/7nSqO3uY+WWYTlCGg7afDcnqWV5cH?=
 =?us-ascii?Q?1//qYLKZ2VhUATHTuDuT9PC7J1jX541upVp4zmQ/vzpWBZdO7g8OkKU+NXHY?=
 =?us-ascii?Q?246D+sYY+a05Hc+7PCmy/tvigEiGS4K0ij15Cj16J6IQzu83tqTxAhfuALPp?=
 =?us-ascii?Q?6UWCNkk8L2Xk3ZeXih0ltqLJW3cI8aSuynBrF/BIuL6RGnPeY3FvoIIo+iTY?=
 =?us-ascii?Q?HAAOGFDuP+gWXG8VZNBFq2L7h9HU8/7oHlATpfz1CXGY6oRC73tbwAJe8gWl?=
 =?us-ascii?Q?3WaKxtLewQfwYQXiI1gsoIKZ4+nu7qDJ6ShVxM68nATGGcAbLqdvbbsPfcU5?=
 =?us-ascii?Q?ppfJkP04xBBe77PlnSgsOL1TJlPVH6+eaOymrxq+ZKfqfPgncptDwN/Ab+zv?=
 =?us-ascii?Q?lP2shfy2xo2SfpFC3Th0mrLa0P4FArPRMN64edOIOVeiRGVgHz7wFqWRewHI?=
 =?us-ascii?Q?gvaT0bM5MTIvi0RE4iwE6fupCny2iUst8fFofv6gjaZ2iw+B87dq1HXRiVdC?=
 =?us-ascii?Q?fpCf04WFUjs4JjH7Rq7NLWDNVimVw7aIQ+0MBfCIFNAMoRgo8njQ4NyN7o4x?=
 =?us-ascii?Q?JFQ0LLVAqC8jQjHiH73decuLkjwGLcQ5syWs9fKNx++BKWNXWuueuWQnqC1y?=
 =?us-ascii?Q?mcaXlG530V3mdDy26gTXQqXHRVFKW8ZkPz2GnC/Zk5BR4lJqjxXEljPxLBMt?=
 =?us-ascii?Q?7Z0s1fnf+K0uDjwOa4w+z1uDRDqoCQZBRr93dBWG+OlOFxh86rS58Y3Aex36?=
 =?us-ascii?Q?ysgdeJeWXdZuB0OrfdjO5EVzajlPfmHIdSvJZpFE0vBtD4ARMC+Wgi0re4Jl?=
 =?us-ascii?Q?jTiTLD3VVucV2wqvOhqo18jc33W2rNBBOpKzmbrmq2p7bDKTXvOV/XxVCGYz?=
 =?us-ascii?Q?QSr/uNxF+TaDsHjAHtJ2iUQV8aygm43CJvs2b7ZC6CtMeMJHxrmeAjpGD47c?=
 =?us-ascii?Q?kGcjKkuvvrqFEJEMIbTTHO0d3BEOAjM7GqGfSbrgcD1JIAw4cuYPhloIOGI2?=
 =?us-ascii?Q?xS26A25856F0Ri5Jm7BsfEDOky5juarWy15bzNLSp1Rn1mcH0Gqp3WmdTwC5?=
 =?us-ascii?Q?4oRn2TwiQ2kTggaMdEckucf/h4DppSTe0/yLlMCaF9HLGIdo9R86f3EVoCMO?=
 =?us-ascii?Q?ndXp6o0L5uu+jtseKvzP4i/XUETChOmCvJDEJjEt5MoqarfAx0auIJJ2vKLW?=
 =?us-ascii?Q?54utvClwXM1UHiEJTAK1eXs+zvUZL9S0z3DcXRD+97O1mqLYvddvBSyb/8AP?=
 =?us-ascii?Q?jnHTBOpfBcAFtyT0HFO2uXp5MXsQLHgU2Trjc3Ir7XjUgtq6rqUcTGiAyMYu?=
 =?us-ascii?Q?4A+sIkVYLehAf1rUuTO1QU8vvIfz6jVM8kn6AvdKAc3nHcc3XVsYTYaLD+vI?=
 =?us-ascii?Q?NH5OPvHU2r5D7GBrKBTpDSZzKeDK3kBb2ChswQecgrL8GmyX/0COXj5KRhqe?=
 =?us-ascii?Q?fuTl+7aYl4UjQa/X//4kXqKf3aAw9nztW+mG7t7q/yM5BKjTjeTAvY7890TN?=
 =?us-ascii?Q?uMyekEyE53yjRL3N8aOacNs6bI3bF7W4ExxREIXFH5l3B7keDUrvysHfTQoC?=
 =?us-ascii?Q?jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qca.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4567.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de04ca6-a676-42a3-9ff7-08d9f5097e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:12:17.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sO96iQhpQO6ghCuJpnzw0ipG9eMCDc90VoB5sQOf6XyGSQSkwJYdBJcSHAW+5Brd4PyL8vbdXT2eq4X1BP0Yvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2834
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(submitting from Outlook so formatting is weird, sorry about that)

Hi Christian,

when submitting firmwares to linux-firmware please CC linux-wireless and at=
h10k lists so that others see it as well.

Kalle


________________________________________
From: Christian Lamparter <chunkeey@gmail.com>
Sent: Sunday, February 20, 2022 02:03
To: linux-firmware@kernel.org
Cc: Kalle Valo
Subject: [PATCH v1 1/5] ath10k: QCA4019 hw1.0: update board-2.bin

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

syncs linux-firmware.git with the latest releases from Kalle Valo (QCA):
<https://github.com/kvalo/ath10k-firmware/tree/master/QCA4019/hw1.0>

Includes the following changes:
93591ce ath10k-firmware: QCA4019 hw1.0: Add ZTE MF286D specific BDFs
29b419c ath10k-firmware: QCA4019 hw1.0: Add ASUS RT-AC42U specific BDFs
fb4e69f ath10k-firmware: QCA4019 hw1.0: Add Linksys WHW01 v1 specific  BDFs
ff8c56b ath10k-firmware: QCA4019 hw1.0: Add Plasma Cloud PA1200 specific BD=
Fs
89492ce ath10k-firmware: QCA4019 hw1.0: Add Plasma Cloud PA2200 specific BD=
Fs
faf338c [v2] ath10k-firmware: QCA4019 hw1.0: Add Linksys MR8300 V1.0  speci=
fic BDFs
725d7f6 ath10k-firmware: QCA4019 hw1.0: Add Luma WRTQ-329ACN BDFs
a92ca29 ath10k-firmware: QCA4019 hw1.0: Add Buffalo WTR-M2133HP specific BD=
Fs
9f771d2 ath10k-firmware: QCA4019 hw1.0: Update AVM FritzBox 4040 specific B=
DFs
a633c15 [v2] ath10k-firmware: QCA4019 hw1.0: Add Cell C RTL30VW specific BD=
F
46a4f4a ath10k-firmware: QCA4019 hw1.0: Add Aruba AP-303 specific BDFs
0e51dac ath10k-firmware: QCA4019 hw1.0: Add MobiPromo CM520-79F
15f1bdd ath10k-firmware: QCA4019 hw1.0: Add Cell C RTL30VW specific BDF
c07b12a ath10k-firmware: QCA4019 hw1.0: Add EZVIZ CS-W3-WD1200G EUP specifi=
c  BDFs
f688435 ath10k-firmware: QCA4018: Add D-Link DAP-2610 specific BDFs
b529a8b ath10k-firmware: QCA4019 hw1.0: Add AVM FRITZ!Repeater 1200 specifi=
c  BDFs
8f150f4 ath10k-firmware: QCA4019 hw1.0: Add EnGenius EMR5000 specific BDFs
1fad4d7 ath10k-firmware: QCA4019 hw1.0: Update 8devices Habanero specific B=
DFs
08fccb1 ath10k-firmware: QCA4019 hw1.0: Add EnGenius ENH1350EXT specific BD=
Fs
0d2493a ath10k-firmware: QCA4019 hw1.0: Add EnGenius EMD1 specific BDFs
4f719af ath10k-firmware: QCA4019 hw1.0: Add EnGenius EMR3500 specific BDFs
e2fe755 ath10k-firmware: QCA4019 hw1.0: Add 8devices Habanero specific BDFs
38ebb2d ath10k-firmware: QCA4019 hw1.0: Add EnGenius EAP2200 specific BDFs
bc42587 ath10k-firmware: QCA4019 hw1.0: Update OpenMesh A42 specific BDFs
f305604 ath10k-firmware: QCA4019 hw1.0: Update OpenMesh A62 specific BDFs

Cc: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 ath10k/QCA4019/hw1.0/board-2.bin | Bin 607304 -> 1081212 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/ath10k/QCA4019/hw1.0/board-2.bin b/ath10k/QCA4019/hw1.0/board-=
2.bin
index 58046713c3e25f2332d00550778b897b5524541c..083a9d46dc8bc625993f39117ea=
e36e6611e3421 100644
GIT binary patch
delta 33089
zcmeHQ3w#^Jnb)qgdiaspvZFYTEX%SY%P-lM-NbfHYUk0PAx>gAo^1#*30zVfFi-;J
zD9fv9a=3DoS@f{aldqX<X!1=3DSaDu1ix0<a)n5LMf$p@S_Lx2qE-<LLk@D(mRga_s#6C
zR<>kYv164V{$!2*{^q%}Gv9tQ^UdtD+ZKHKS=3D(LrafkSImhX0M<l(D_uK~V-)Va}^
zlmFeEW)pnPQckm_G2{N725H?L#!8N?f8AIjwZ6t}%^>}f@uakBi|Hj^dhdJ2>=3DIJ^
z8dpL>n|ODi^;$olVU~J+Wc<A^o=3Dx~Wjiu86y>9$BAD1CHU*jSffwjl7rPaI4kLsm6
z-{n^2Nq1D69>^lK|H{{pGx?TGa`=3DdlW%c`OYd3G^bUK~02ESJxC83SHU3%vL_l-=3D^
zrIOR>aM<mIg)Y}LqVfr67x-0vKA9zPvsd4@eMfIN+H=3De8BA`Go0LIa|TwzyLv}$nB
z>mBs^ANLOpwaE0O3ar*$@b|z2y9x?=3D;V&5MCC7iuE$72glGACh-Jo+Ic|4v-2<jsd
zbR$(&RYfD70wkx?844CAhT!LPvc$mkcv!STBo-~um3{s7w(-awBkOpiNh=3Do1u8Bon
ze3|$9d&8^(!QI{)w%hwceSOS@T8xClyLayn!dK(&n(cPlY{+6Rga(4j1X5h-v%|(n
zo^<&yIHesvTx3kr4)cqo)>pZ$pR*<?o!Vv$=3D12$MHXRh8^Gst`8QoLF>F%u~iXf&z
zU}%f5ej2JjP<L%8$EnNZ4(Yoy?C{&S`fuh*$3HN=3D&q;T!)F0u<M=3Dx>ar6?1aBt_xj
z^?DS6Qvu|qghIpTt5Q5rwy+M0A_Q7e;O;fM182&=3DLq#&C=3DXRs)(4>VKOpync2#Z!x
zfkH`BEW5qUZpX4Y9QY`Jaw!GI!cNR%xNZARjvTzf(6J1KpTptyVj^0MlF;q0@F5>X
zVL^d|W|Rm+#q1<6_81!HWA-gASOqODC~!3{+4nYI8EEynrB(mJTj8z{J_DbB8Tl(O
zs{c~_6Y%JFq|Q^q*397}pBU$gD3?8Mm(yWS3lb-gF<vn%;M61W+$BAsl&|tk{WWPb
zCarG?1EYE{fgU_Zy28r6B6njkJTMT!)~KaHpvd5X15qs#@eoinX^fyup=3D1;pNx|TJ
z7H3q9-rnBbfg2rj^!@$)<mh{X&7g3I_>OR=3Deqdl=3D_q#&A5P{MpMSNtC9DP^Fvm6A%
zawiQbM)ok8A0A0l=3D&_Gc3D$2M?O8Q-xkH8aV$B)G08rii<Agyu)-Lv|ZR5ZJEgn#t
z#=3D(PHeliS~r`D_%Lxrfdq2<eXHN6>Hk6<v?Cbc*eO3c@W2?oj9UvsS+`!MK07~KPX
z=3Dnjl_siMl1SP#Ra-JlI4hwSJw9PbiGujv#y_($GP`nQ@BNn~$1j!BB8FNY0H9QkAu
zpC=3DKU<tYP<hqg%Hc#M0;fP<#limX)nH^^;Oa8C!aCC&szOaYEf^2rM=3DLT*zys_R#p
z^#F<rBv~c|gK8H?#hDWHXht{`S$ln-DjoV0!*Eogfy4ncT(uyB{c2H$1~go9<MToZ
z`OW_dE2(ae`h7f+GZ4TQ&r|+GzvZN7wqU5+fdet|zUb{D4$p!huKI(_4S~EF=3D+|;6
zCZ|6Y7Pys^@E6AueSKOE!;<47!+W_>=3D;vIcVU#478k;R0yyUFopD>Z*OAO7ljpeLd
zR;L;BR(6ipzBB`2(0M>LleM4eLO2kfSjNggSZ-|5Cv>W$RvO(PtI0ikg3N2*zR>9A
zhmGw*vgte_TMWe_CWa9;Ksa%L#M~s&)E@9KLn8jjm_oG!ME0`~BLgJnCXS|Fc`^{{
zh$WXSOd@_PR;+eGv_7*~@Z`u76XK5W?IO%k{E)oxso-vZ7^$DR`;i8;9EP<yu^hA<
zhGQM#363`0G&ESHy|O{*#G39zn|LbW;F&P(omIJZ6cXzv*lkm}rjeI~gU|<ensTJ}
zX3K@Vl)aN5rn0U!Hq03z@LqkH4RJnSVomDbZ)(v?N8aUT<;}F~FGRZzOKbCtPw2%k
z6W*vQ#8c`Xy@YC01+r2V`|00{T1mfyx>~1~T%9D!XxS@sG{Qd~CXGSIYvR;hX6h9K
zF=3D+nr6^#F-o>tOI9@|6g?Hzqzl13Thh9$XQNt2R2#L>AYy<t=3D6p*E4Pt4Ib@m<b!H
z1|yNaepwUJ;!p&p2omtMVYHYKG8euI%~inOy?cw`O9^-?U&dD`;Z%=3DgSE#LtWMQ;?
zoB~|f9i$f*qL;$(Xm>89B1#NvUB+iAvodIN(PH9jGQG#Ok;neX*Wsulb8dSb%q1?r
z{Nl~p1vQ&*yuk%o`<(Dg@{1P1iep1XSB^y3$Z$xVL%;zvBV}l~i?(xgP+k9eCq(a+
zZ(<}8Obq*#(P1=3D{IDm#r-v7B!A}YDIgz01e{Wmcj9GrMqO$u?*Mh)-;%9+?W(;q+1
ze1MJ^nM(&deOeB~Fu~(aah&-CC%v9yyo(=3Duv<WM{W@sMVDdEcns}eSiSN5VBc1hOo
z_y4@emL$nhQ;`>78&s=3DV2K1(5a~<hHZ+5a6WZwZ}8O(}Tlbi^w!`UOo?CchGEC+Xm
zJUwVEAaCmVd&OjFM5fSVj0<Q_a?L5{&aQdqngg+GCO;oEX3?upgc8*V*3^iwffuS)
zX$lz`j1@RC7`rb~nCVgOQG6IJKTzlEXzRyEuN+p32Mz!w;A_KB95`LwRNRXp!~N(E
zG92fUHoLLh)zZ>Wa~h!OG92$p&R$a<M~YAC^G)qtS9e{1%}rACNqt|YSOqIsZWj!)
z3Z@8ERaJQ0u<TI)i$LR}l5qp#jEDr&Z@cngzVM;Ii#{)W2LabeRSON5a^zI8Aw$YH
z8%U;lX^-a_f-VuR43>Tz1&)GIXr5!9%!{EyN1@Cc6TzaeorN0*;e6)EfQ|%7kCRM-
zR3;WfgxS-xjx5LZ(#11OC3Une^(d*uAZ>36k4Voq8uByZ&0=3Ds88de443}cpl`nfiY
zq4R+j^6(W#OCwA`%UVKcK-LD-1&k+AQXoC~fI=3Du^DX|G?C2k}VN(_}WqtQs>0ExMY
zqoD~5`R|_?OENV>GQu4;7LlC8##wWFHEdNI>g^4LW_kVF*`)J!oO<3KrXhpOrSdVP
z<uD9ZEaX2A8?y>ns+t647@J$`n8n(RV#1QB&FB_<UX55X^yCNca<iqHUz_UkU=3DiF6
z)&^+)l@^4Ph-t}K&R0z1wPO+1Peb)j$dV;rKou<nDs#R8B?u~0b7Wqf@2_Gi)o7(@
zE;+8}dxdZ~6b@tjaS*Po4~`S=3D?lmu7iaHXb*w}=3DMFNF=3DW7xaJC8N<UZ`-RD4upE9N
z>RAV3Bbu{LR>?68I^yMvwdK)bZBAN#Jf1SmaB(r!30s(k$#9$tmG5zesCR^_g$&2L
zQqM`VgCmO{GFiw!l$kAtIxr`dIv+As)sPqSEzKlSX0}r1V;xmB4;~cQoOI!a?oHQU
zSGA$5r`o@;t~O?U`ofi@wuvw1T;!ue`e#YwheD3jQzzU91Frjp!zNJLwviXY{L3P!
zoKA;qIW;8+RZf=3DPM9^Fenjm1{D<|gRQm=3DO*D6f>F@^4iXmdPoF<X>k<F~$UwNk+Tr
z6INW{@s?LqR+M|aKb$=3DDlqrb~CWdHWLv5Qp0}N7|CmEwhDlmdcxZMkY_9uqayp=3Dk^
zBrrqe2g$xS3^o#d!;o2`G7FQ$BkK+u%f$e*`(<uPsoUdzcx;!J7R$;?oY19tvutH|
z4$^~K7c8iCJ=3D@7Yzhc@U4Yl)|W=3DU5q)9*KktfeT;m6;?=3DBTtlj$JiNr(R9I%#hPja
zJ$154%Z7JwA!mWsV;nHPJgdkPjEm1s>Gl86|5Q)!Hm$}H4j5`CrlcMY2Tn!KpU<wD
z^(E?#<<XTmN)fZnlm(ooAgOzR4eGbWGEEY3aC$tF)pF{&V_l-<Y8ep9ES1Le5L1sb
zr7<A?Q3Zw@Pj7PE?ZAJ|fybIrnNR@<&J=3DjCbqc2@rODvpVh6N(+J`(T;45ehZ3L*?
zVx>&UFxG++CK;yd6dOxuuyI_t?y|CyG2J5CrJ2j}*1AOw>A5ooCzn*+Dtk!+!@A2j
z18QL8Dqg4_KF%34<o=3D~Rv*4L9y(*S{EL{v$tgKweJV%@3d`F$5$w7Afmb1_3TVG6l
zOZvlX;biW}iCq%9#^9u_cx<)jochjaULZuLL-T6gXy~G5PgihaQgteIkFoTu#A=3Dqq
zaW!}((%Dkivy#S`QNW6dW)v_*%}{<(-9S?QSAQ8h6^}210@gi_>P4$>Y}JeTj;DZO
zLgY>}f5LJbY_CRI9^gLklA>2Ri|3l#w`{t-di~ASx7JtRx&f!o{<`{_TYBQmN8abj
z!MDv4x$0&^9nOdKkZsNUGI-!slfBQG9+ZYY61*0=3DRgJ9soe8EJaH8CWTldm}V9j)l
zjA^yfhr+o+U>7>6q-pJ;F)pjUl+jff<7^{OATCTbP@Bjzob*(d<tKE1>6^o6%D*MV
z8W_3z09QAm#<lGOx~55Bv;Q9QgQtakhI^d%IHhei%k!GeHKJc8oXW(OMK`!p<aADk
zhiT#6f~}r1ayk{H;gu(1Cgdqg{jV0FE%X6B?!INUL*O(9Gq*_Xd$y%3zvQp2Uexqe
z%|4LQU&799vzL=3DTJ!V?Ssa-2rD#xZ3n=3DoekMz%QIKF5+}gwDA|`r7x+9~*|RJGOP6
zw7l8!BUTjY%m8<{z%`T89Y%lVO}AX#Ro&KEU0+*2{M=3DK%8r+{^=3D9+04_m-J6;sR8B
zzyh!d^z8N5ba$_>y6KzU^|f1Wl}elVY8t({FwR4BZNfXd|HOO9-K#j8)U(uJ=3DTMH6
zNLOBGD#|#o(8d%sFya7&<Z@1!ClwpaD@(~b3xDZjm%3^Y$d>0p3mhczwTDc=3DWX4cx
z^*1fK<=3DShzx^Jky?Ba{6SNiMf>)Siy#NJ^8$5|ULy=3D|v;8_3K#Aswe%2fwCm<c%U@
z19|ONhHfG{jCJQ3bnJto6-Tk3y!C^xAa=3D|~SD~-u>-Bn$!vH3Qbh;mtZ{NX{1&+h=3D
zzoXcAGu*e;(#DU36J}0Fe);dF?}>_GU~ziLJJD=3DOUA9m@Jgen*JbCk0{ya31Kawqk
z?poLCl<xi$7tmWj{`liR#8cp?Z;{3rMr30qMO{eKub8HMm27A7S85_XzXHuxwR!xI
zGjv?OW~0>ej48`3%MdDr$CV#{mY}oiMGzq<KPqJTkzq2EnkbVW9b^wDILYcFZWcK`
z#}XiGc)^^#ErWd^l9Q88zivEgk_tBoW)6hIHuBj?&Owf63JwquXEKG)n}8U~x-%d5
zNy4_U^xR%G*O~m)sz?h+cm1<|j+=3DAW@g_aLLD#b*D%A{`|ItK3m+1XP9k*=3Dms=3Dn-^
zi!ZFM_cygIU8Oas{~uD*#5*~c)Y-(Z;WdT<r<U^1it}Znx-?AGvyHm0Nh4gqK`Ja{
zzlb1FO3KM6uqA7Od<Y7_F%TL0FJt9!cFQ6g+kpqE*zHP*rxl6gW=3DyRW=3D!KsPB!X2L
z)Z}E6mTv;w>9auV<v3>*d4h52^056WepN=3D!$aXC){>1b^=3DI5!=3D{wQmv(SBhXtva&~
z8;a=3D&ZmBwg^P>gV&ELAYdh<<<^|iItTWYJXUB6y4;0#tMBe)g!(h*$iaQg@IIBqKp
z(p{wXI#bs0&Qrb&u^~qOT3;1xCTM7ofeXCOHLrZanZ%u}U?ET6ueW6O>gpK{*ORU-
zCKq}6x7?=3Dd%T;5;^2D%K4NzMyCs1FXBy5Emwn7uFLXB1d7SgYSxwD%dw4rQ(qBhU>
zZKp>HmNT~sW^o>`(Q+6joj>8)$&pt~m#KqC*k7$wy+^qn9+z_(c_QrmkZ=3DC<W-R9`
zLQ70b#&W(;|Fq?&s}{s`Wi00_(CSwQg8TI=3DDxt-ribSWUWQTTwI_Mxci-<Fa3ei53
zG=3D_YZ-nYf1A*Rq{jN+Z2<cd<yT|HB;y}i7iS-W^VAW}5ArbV$tZE4Z+lVRmty@jP^
zm|&F;qqi_T$|a}Y(9eOLgbj49Lw;7!k@~pLiN{}3M(X&SfRTFZ@H<a!$((sEC=3Dx!c
z&jsm)+f47}{&=3DC~r<|Bpf#h+kB5_(DM6u_Pn9k<`JPt(Ej?yTWMfr)8rt0_ba0u$j
z6KjS$-};DyIs2U9XUf)cGmixj6G@*Je^HNx_el3va~VB)+|k+Hb@S$~rQJ8&vZ1=3DO
z4bLEt?E#rNfqdo!@@YAN92P3gtWDw`&N18M%xUC!=3Don1Y!A6R+Lo=3Dt5pJm0RQ0Wue
z!#Q&rIh(eXPw-S9k?A;%97jv^vFN2o^^FigXb=3D{AEWTM5X#BvQm8;Xuu1B*5p6BU|
zRL(KeJ*4S*&PjY93SS*wb82IW$c%DugJN0`OdgDrF&m<SnThLMAi7_D@=3D2o^3`-?N
zgnQ0XjFNJUk%nOY!ABo`RGli60X^IysR!&O-oWqOOD-%l&Q*Q`cRA)!3uB1&_sNnw
z=3DN|h88U`L2nLF$^k3{wjjNuVz+x{B^p4<R?m*-3f>?VYspKcfh&<ggV#nEV3-2fhs
z`_%G15>AGpg4-8s&biVapcRLMdtw(GkLgj|Zn}j%%G^E-8Xo0F;hNoCm|SN!7QxTy
zMf``T+xW+nDUP3!)|EzkW{ysmLxqaY05W9`Y2}1_0=3Dtg{6P&f(Z3vur_70RV74jFR
z?6J91Ni%5#_JFbp=3D9sA5HKw=3D5SDCf<E~K4dNIvf*iU4a8=3D}GD$fHTxb5Z#eo6+2Tq
zJT8R!_!3(z)PM$p*SE;g-<zs13<4V|xy{s;+mEOH_G?`7=3DGTpjtbKTlUZ2(-{%G?d
z`U0Kr^TVf4m@<gdqi^;qOEI@@ytTHjdP|*lwR}%BwhTkQc1rka)-(FqEy|bF9y8rX
zF0T^`49JpRJZ8FDHhdJTHB?pUE%UgMF@<P>nqDGQo`{){hqpK@*P82U%WbpPS?gS6
z=3Dze`+M^xuyG&H0F<wnPT3z&@`Au6!u($^um3a$9b$<47ASjk-yHzzOGZ-tMm*@~Z9
zYptu%im!!oic#GHZ2pw?PafjB45LV57%Tph2m?LYSJ5pI)HI=3DQk7A)<PX=3Dv@VIz4k
zF;uK5=3DEDmK6pDj+xp~$+*L*8}mO7T6T6%u&3daiHijMl+dTYJw%U1l*P5AN|JQRoV
zaUU7Sg)?~Em?z6mac#KYez(?@V96?+N1G{_5zEbU+L1VJ##NP-c$Nc%I~Pcte9}-p
zxqxSZx+W8OLUGBue=3D^&^{O<3hmbE;`quu)&F4vmlDsZ$qT65bSa!;%?z#AlvUuP&>
zQ3mVLxIx;34kcF^HDOQP10LZkMBLN`WUo}ZB`kzcV*FG*bc%Gb%JOB2V~KA`$C7PJ
zaxZXP;Jcv1FAEt(%ye{KOd1S4Sa-vfiIsl8Pr0VJE1MpV^QSC#SY3J+UJyp9XjHvU
zhsV5mo97`F#9B!iyQ`F)lE)}%m_Qhk<3`@yUQ+2TErmO`!0YoT$7Q9Z9yp4i48tVG
zs9K6>9$t=3Dp7RsFrqj@1c-UY%W!}->Hm)(k=3DeAlwimgROhI(!`+%XAIa23Ly}KMmH4
zuHF@X{AXIX6bMdSh`D7HYhAAwwNe+9608`Q3#D0rC5gGnCvd#v`|KSszE4bMXCh6e
z95fkb(!1hbvg0-52u)@kCu~AP-g*maGB`rkksDWXmkj%!K4c-YvV=3DQkG@2QWMo}xM
zQu7z5(Wq~-0Sj$Zj;CFli77KPdd(!1q7?NSFtfW-KcmseijAzR&1f{KDn~OKjjHLS
zU!#$FZZyDw+4M!*g-Z<?ISu|xG}f_yd+*2%qx3y?TB|470uaq(nGq}^236plVqW=3D#
z6IABaV&@8HT4`Y#8V=3DQ~fLthX^GWB+a6BY^c^yk0y?;1)ST1MN&@iZhnsmpqjD4iC
z^3g}VW4qKcmRUgIwyAbQ;$6j!s!_D<_HSNOwfS0q<H8NGg`3i6NABQ<HyD<XmCu>p
zR<{_#i)L}H0gv0Z)7MAAYHML(!8Gz<{wO^e%lYElqNn$Y<1d)LsOub8zp`fY#Hfww
zjcjXqqUN*cH#kRc<8;FxKDC_F|LplJ>3cTIF?D~wJRuLQM<KS*Y=3Db>DSf>RAHt;yt
cys`;qBIRr`4bn}B%MF3kCsu2%xel5BA8fLlQvd(}

delta 212
zcmezK&+$ZuYC{X-7N!KwX|2pw(~m{)$}ma4*e)=3DGDTZ<T0(U+wuFdzjpG$9-HDub%
z4pd?=3D&60_0x?Kma%=3DT|Td6e|q6F8ZGm>Gy!fS7fA0w<e*$n+0eIrOKm-^a>5{h2z)
z$LaF787ro%cW@|eU%Qr#muq{SF~?CAMvmzpX7hA!KOe#IKyUhW4GzWW0&{q>x6420
zkmi~^FN<gTlt~;}(<e;gFxvia5{Ik`*ce8x?E#t`dR&v^PV#O)e~_bBxxGM^4T#yd
K7szs0Z~*`_*Gzl>

--
2.35.1

