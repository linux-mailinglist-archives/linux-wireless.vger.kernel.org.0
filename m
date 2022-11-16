Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D934462BC26
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 12:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiKPLiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 06:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiKPLhc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 06:37:32 -0500
X-Greylist: delayed 2003 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 03:26:30 PST
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34837101CB;
        Wed, 16 Nov 2022 03:26:30 -0800 (PST)
Received: from pps.filterd (m0048274.ppops.net [127.0.0.1])
        by m0048274.ppops.net-00176a03. (8.17.1.19/8.17.1.19) with ESMTP id 2AG7aCa7016060;
        Wed, 16 Nov 2022 05:53:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK85U/vK255AuyYxj09hLJ62/fI0sRDWyilOfJIJ8LmFB9aCGm7jxFwjy9JFzJkb2MdZSKWSTLW4gXVyY6kKx8KtytIAEuAQKwLPbIh0ZCw6FMrbuhQ6bEeesp6NEoI1CHYUwYShlLfi/3TkCj+30BIOoHhA7JdiUfBklom1H7TCBeMJ2cS3/241C0An19iv4iyf8eiBcKu1IfPe4eI0D16bWEv6scBQpk17qo7PqsqDMuY0rzjqjb0NduRlE6G0ojoO2PR81iPHWgObky0ObjFk9Od00kUflEz1+SId0je0I+K3fUIZLwVGqY5SVuj67pH3stVenl9D37ribP+MSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCwcBbQbNw+we8HaW7HXPDG4N0i3iLypipCXsMSooJI=;
 b=WD//Gjm3RYB9PcmQuUxDeW55WDaCru2pE/iNTUnQJMghb/5EuNXdC6cimrFLwL4N5zdrv0LvsUFXOsxaDflLp1WpZMQWWOda20+5/yf/Xp5W+vXS0GXAG7wbg0CB+PT7NyxR6Y6unL2bvRcIvYu18hE/pFLamF8SND7Pk+SVB1bOS/LXKDMxqw+iju8EhDrDPACc1zk9rawhIBEspgOmxkSKAY9i4vmI8mEVh0fEgufKeBuKuYtx/itXiKp2PEs26OAkc3WISQc72YsKk9zvN9V9qdbUBTpZQutSL4oFgR2dRoIWPQKNTABN8MrpRN7ofOKaH5qChauWqbabf7q8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ge.com; dmarc=pass action=none header.from=ge.com; dkim=pass
 header.d=ge.com; arc=none
From:   "Liu, Kainan (GE Healthcare)" <Kainan.Liu@ge.com>
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Issue about Deploying ath11k on SLES 15 SP4
Thread-Topic: Issue about Deploying ath11k on SLES 15 SP4
Thread-Index: Adj5p5X+iZlA3/7BQR+YkFk/+hgBbg==
Date:   Wed, 16 Nov 2022 10:53:01 +0000
Message-ID: <DM5P101MB0237E3ED4786464058E592E6EB079@DM5P101MB0237.NAMP101.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5P101MB0237:EE_|SN4P101MB0285:EE_
x-ms-office365-filtering-correlation-id: c951d124-5daa-4248-3a17-08dac7c0bb19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQqD2yYPtmz4kW9vlG+N0wrKXi8Aq8Q3KXaHafbUCjrAoxnCbb6gQK9wERzN3thOExAYzeAut+pIG79ll1VGhFeGtTsDljhi2KETA37iRhcdZyX+ob5qD6REGp4/Flw7gojy7QsGiwUoLdVqZ2DRSsWeImRL8tzuLVMYAmq7WbIBBWFFZqSifTBAYZqn1+Wl3UT9VHzTP1+F/gpI/l0jeXhZDpRE/Ki8misX/QPBGUoYSTrb4rDbAOfUYJbOuU6CLdy4C2Itjm3K2PIhc8kbntxxpVvxK4AS6IKUfOEb9BnQ+0qnqxG02yPQPEM0jLqfuknFu1wMvqB/atpFRjOylO3HCdhrmTfEyFacC/2JyKz4lHLc+kVB9qwH3WiODTAuGAoLtYjX/0YSmXNoti7+DcP9N4edRQEGDr67WcN2J5oI7A8P00Rd7wI3vqOI9qjNNnEDiSVqu/47ZSitNf9H3DGanC/YALf7rZjCX2qz9B2P821BBEw3C/bLjMKbpIymispuSauhH9/ScoGFuecz4by4/8CKUCvnjDk1sG087TvhlJx2MEREIq1x+EQWltLWRtXk6uqiZnlJ25SlHVeaF727AVqgHBRSqggCCSK3PG7p6HsnA8KSo6z/qQTmDxOhqE2xkyqng3Cy7tWvCzd+lt59LKz6RX1wRJ1PtONeDL4VsnMVeqIm7ApA9CUV96VSx+zyY78hASU1e+/DtOOzEuy1O2HB8+uSjkTToxwyJs/vEPmTk9ly+/Pj9oq1t6MZMUlds/q6F2K6LAfJCS0rUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5P101MB0237.NAMP101.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(38100700002)(8936002)(38070700005)(6506007)(7696005)(82960400001)(66446008)(66476007)(66556008)(76116006)(8676002)(66946007)(478600001)(5660300002)(450100002)(64756008)(86362001)(316002)(41300700001)(52536014)(110136005)(55016003)(71200400001)(33656002)(83380400001)(186003)(9686003)(122000001)(26005)(99936003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kT/0aTdq1P0/W/NmBIo/8BPww1Y8OPH8RAHEycRmE7JCje6v+KpOMfhR1d/0?=
 =?us-ascii?Q?QN0296pcfVycuk4sBLf65K0I45tVXTymivEyqgQw7WXU0k9dr3mseH3ZfCpe?=
 =?us-ascii?Q?+IfgutsWilNP8WBPwNHDL8cr2oajFDFjyxaRxB4/wSuZz3pGY+URFYTsPo5v?=
 =?us-ascii?Q?h0eD0iILew+TJEfCFh+KLhQttKhF5sxg5cauyQpdmEGBtLt4SpYCgvZp7Jnv?=
 =?us-ascii?Q?P7CMtBLkVsdrQziW/CIpciBciKSENvIMJQ1fGbUSyUnbgHWoj39UtXNAK/lB?=
 =?us-ascii?Q?MSJsuflH5m+FOqeBI/DpE+FjK7AV4q6Dhdl4QVQSq8+ZRZqeIRvKOAwAKJ+J?=
 =?us-ascii?Q?nWAfjsKfCfWZSsXUV5LvG4o9QW18QJ/Nsk11PbowCEyk0hExZ23c+pEjtzwW?=
 =?us-ascii?Q?+MvZzifd8j6aJ6aMAI/KkPI5d9k10fghXjCrNLz3b0mBt9tuqWNRNA4RX0gj?=
 =?us-ascii?Q?m7eEUM+/QlQOFooyHvoBTqxoHPj0QC5ifsCNThpbhb3aH8dTGVTzgbXXGKXp?=
 =?us-ascii?Q?yrD3IPyMSFYCE9i2Kv4mJSe0mM66l5ch1cksGMVbViI3/hFvZGxfnxs6cAwk?=
 =?us-ascii?Q?rTQoHfCeTnWJZBi3i8xNNwBngq/+mKt3XYYf7MVZP8nRYvP3RBvUFAn7O86e?=
 =?us-ascii?Q?YA0JGb34r4z1Dk5ZpdsZmEnGi+W5N6UmriJ/5zT/1MwCa3zGhb5QHl/+Hzlx?=
 =?us-ascii?Q?w3SRbkfhj0sYidmWVJCTWphzGS7fQOVtJrZCbympoUR0/0ynKeksr/28zO6H?=
 =?us-ascii?Q?/Nhg0MKMZ90TuTB7JLTGRDJbkc8ilTIV8U/vNs2VoDE12/6eOeZIwd3uCNq4?=
 =?us-ascii?Q?3YaRaRe9w29aJ46P4clitPXhUQ3R5gWshJ58WxLxj5VzGn9tFtoj1k+DuuSt?=
 =?us-ascii?Q?GsK6as8NsEvZh/YlF+AeVmxhumdmIPMtu+kZ7G8gyz/inw7lSsx7cIR9PjRV?=
 =?us-ascii?Q?NodN1sH3mbkSbdpNdb1qIqB6jRJIOT79hpV8h7vKcOF7equrqY46GD9VnhoH?=
 =?us-ascii?Q?IofWEaKqPdAD7jNHWMsfChtb8/Zf8CfEG2+0CvCZDy03T3zxgmLmBTAUPP/7?=
 =?us-ascii?Q?CIksyafXBfL/sVNJRbffjlxpCSM50UD6PoO42gXZcJZmCdWx/xpZ+RQ9SIgh?=
 =?us-ascii?Q?YJb7ltlqf+aP0lISJdYaHKm4n1UMIMS9jYqy0RxU1Z3WdA3XUZXslQZMK8dQ?=
 =?us-ascii?Q?PdAk4tVB/tH6uRUWAwUP3GCF+2+mVcYCqB/KFlidCrIxTioMPFUhTcPMFdGA?=
 =?us-ascii?Q?xQN3BBSso3Tu0rI4OgzgjWpcVU21hEW2M4dQ0G0i/mY5164qiNKzJzLQFKcG?=
 =?us-ascii?Q?VBFz3aZnwTwweh6eB6yi4NOO1ET/oCPwNd0bxK4q0nK4g+cPgl+kjAHtlhd8?=
 =?us-ascii?Q?+sP2CzxTV20gWE3VUaIYou4pJCucsd0U84LpTRhtdcFoD64Jb8l0/i3GGyrU?=
 =?us-ascii?Q?ifeq+0qucz5f+MeniMWKvQeZPwAEzYexDT7rvPMAJfT5RFqVY3joTpcBures?=
 =?us-ascii?Q?wudrKScZAuGmR1KzZFul+0zwhnv8M6PGVEnrI+gb/ZPPW1V5sQwudiNJ530O?=
 =?us-ascii?Q?zUdEBylyQ5SZa9ZKISU=3D?=
Content-Type: multipart/mixed;
        boundary="_003_DM5P101MB0237E3ED4786464058E592E6EB079DM5P101MB0237NAMP_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5P101MB0237.NAMP101.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c951d124-5daa-4248-3a17-08dac7c0bb19
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 10:53:01.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ccb6d1-d335-4996-b6f9-7b6925f08121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6ihX4Jdgi2v5h3weE8KsX6DVHR7xG08NhLU8LSTXFh8XQsdzgMC/yjhWNP/GQew4n1OdMYAYQdeGZITtGYmZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4P101MB0285
X-OriginatorOrg: ge.com
X-Proofpoint-GUID: yLXQJRw2ch0Hn4FyIaZ1sxNLBDjdviKY
X-Proofpoint-ORIG-GUID: yLXQJRw2ch0Hn4FyIaZ1sxNLBDjdviKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 mlxlogscore=487 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1031 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160076
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DC_IMAGE_SPAM_HTML,
        DC_IMAGE_SPAM_TEXT,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_003_DM5P101MB0237E3ED4786464058E592E6EB079DM5P101MB0237NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Backports Project Team,

Thank you for providing the project. Me and my team are trying to use Backp=
orts to install ath11k on our system but we have met some problems.

We have successfully built the Backports Project and installed modules on o=
ur system. When I boot up the system, it reports some issues like:

[    3.815040] ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xb3200000-0xb=
33fffff 64bit]
[    3.815094] ath11k_pci 0000:06:00.0: enabling device (0000 -> 0002)
[    3.815314] ath11k_pci 0000:06:00.0: qcn9074 hw1.0
[    3.815316] ath11k_pci 0000:06:00.0: failed to register to mhi bus, err =
=3D -22
[    3.815352] ath11k_pci 0000:06:00.0: failed to register mhi: -22
[    3.815459] ath11k_pci: probe of 0000:06:00.0 failed with error -22

I have checked the code, and found it was because the driver could not get =
Length of the MHI MMIO region.=20

So I checked the version of those modules, and I found packages like mhi.ko=
 having a version of 5.15, which was built from backports, like pic 1 in th=
e attachment.

And for packages like ath.ko and ns.ko, they have a version of the kernel v=
ersion, like pic 2 in the attachment.

We are using SLES 15 SP4 with kernel version of 5.14.21-150400.22-default, =
and backports-5.15.58-1.=20

If you need more information, please contact me and I will reply the email =
as soon as possible.

Thank you!

Best,
Liu, Kainan(he/him)
Software Engineer
Surgery Engineering, China
GE Healthcare

T +86 15611095678


--_003_DM5P101MB0237E3ED4786464058E592E6EB079DM5P101MB0237NAMP_
Content-Type: image/png; name="1.PNG"
Content-Description: 1.PNG
Content-Disposition: attachment; filename="1.PNG"; size=12425;
	creation-date="Wed, 16 Nov 2022 10:46:47 GMT";
	modification-date="Wed, 16 Nov 2022 10:52:59 GMT"
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAnEAAACsCAYAAAAUsvrgAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAADAeSURBVHhe7Z09siM3r4a9CYeTegNTx8Hkrprc
6dQpRw7PGhxoAbMMLeCriW+sLcwWZg+6BP8aJEGA/SOp1Xpd9RyPSIIEQTYIsbup39x/VwAAAAAA
8GRc//vvGvh2/VcqcEO+fP2IbXfa//T1+vMBer007+frr8vp+lalv50u11/n9yJtFm+n6/ny6/rr
l0OoHwAAAACzcX8eHSz12n+ZIO7T9fvHx/X7J/dv6vPH1+sXsdwd6ARxa3k//7peTm9iHgAAAAAW
4f68ehD3+dtDdiInPl9/xPb97uS3z0KZO3GTIO7terr8up7fpTwAAAAALMT9QRD32CCO+hl33/79
9t/1x2ehzL1AEAcAAAA8C+6PGix9un7/Nj279vPb5+pW3ycXePD86lbgp8+VvHCr0AriXJD1M8pf
P9xnuu2Yy+n6feGy/324AOnTJOvrT3mMZieMbne69K1vc/rgsWo74doSZThvp+vl1+V6Pl+uv+j/
J/pMz52dr6e3VM4FUD4/PI92Ob9XAdr79Kyaq+N0qoI4CuqibPNMnG//fH13ZUK7jov7zNvOdTOK
INHST8Fs/7frG88jG73jli4AAIDD4P4oQRztDFFQ44MXCshcMPPz6xQI+XwXcKTA6svnr9fvbCfp
36/f3OdUngKuUF/K96hBHA/MKGAs5XX96DblB9OH5J2uUTZj7sTdKIiL5N036u+cNmIQRwGbf/GA
AhqXzp8/o39T8OUDo7d3H1TxZ9OkfGknTnyxwbfPA6+3XF9RTtmJs/RTMdt3ASrZJ7dL+Sdvo6Ie
AAAA4Dlxf7pBXAyC+M4XBTw50BDyLQr5iBrEzWy/yaegzgV5mo5mENfD1U/Bnd85c/KfQvBIu388
kNUhHWPbpEcd4GqknSj6N7sNSoFMCIRiEMN2psrbpVb+RD+IG5HvBXHj7YuY7VP9ZAsX5PEyAAAA
wDFwf9QgqkrnQVI3+GN8dmVSoJOYFcTNbJ/nxzI/Pj5cOWr74/qD7SIWMlY/BL7QLmMMDr98mgI6
8ZZxQwgwC7tkBnWxgjien+BBjpXP6AdxI/KdIG5G+yIj8q7M+XJx5X6F26mju3wAAADA/nF/usEY
BRprduJCoFI8h1YHWcTSIM7Ur4R2yMQAqZd+B+ht1HD7l27ZarYU4EEMC17uuxO3IojbZCduPAik
5+PSLec6DwAAAHhC6E8KtppM45kz65m4GGSlz1G+DbI67Q/stKn60S4c3UqNZbtBnG9HC6Bu90zc
4ufhCDOIs585k/LvF8TZ+qlY7bv8M91KjXkI4gAAAByM+A8X4KQ3NXmQ5gOYFW+n0i3H/AYoPTfm
PovBkNT+QBBn6Ve33wvUeB/a59JuFcSx3TfqV9OuwUAQ5wMo9e3PEGCltzfLt1N5Hie2uUEQZ+un
MND+m+sPf3O12PUDAAAAnhsxEQAAAAAA7BsxEQAAAAAA7BsxEQAAAAAA7BsxEQAAAAAA7Jv4D3qT
Lz3E3jyYLr+d6NPSQ+N46+9wzBnf4bdXH4344oUM5jc4HDPmf4GxPizhKa+vpfYDr8fvf15//vP3
9fvvQt62hH+UbzTOZI+LNdiOpeP75EFcBvMbHIWFQciq9cHima4vBHFglPsGcdoREANgkTsMm+6o
LZAT29+SnQdxZf+lI14W2DPJWv0m27hycxZrOnsvH+FCv4jxXsrOal9Alx+xDz/CxvjFDrH/lvyM
+gVM+xn5s6E+zh6HYOfF64OFdX35cRmb97v0HzP0X8tN+v9o+29ov5vPDw6COHB/wm+NNvPgbkFc
p/0tWeKE7za/6/6H63KTHRCr39THy/l6nrPj4mTOziHm36X1duqM3xK7c0R52z7hMOko96bMr07/
Lfnh+iUs+82x7yiLxuFZgrid+o9h/ddyo/4/2v6b2e8O84NzryCOLs7wLY/BJ6k3YEzvRbDqRfjm
HF36puocJDmllJfkXBv526ZzpO/8QFY6xb+QZ7p5efft1OfTt+Dg5GjAp0NdlfYzwUmtWmSOAI21
ZANtfLX5EeXoAOE0vuphvnX7g+OrHxbsLtw8x6vDjKV+STbQ+m/Mr1k7KU3b9wriqB3Sbf1ts668
2v4AorxlH3La5c+6yd/Ee/235EfrH8ey//zxUea/R5u/wb4pL8PlTf+84vry6VXbRM++dd1W+zFf
90+G/cz+J1lGof8N/UfqP6+jXl+19tfa32PNvzinnd2mcjHQGmy/K8/KeBbYZ9VOeBXEffnz7+v1
n7+u/xZB3e/X739R+j+en3/9seQHBehPuFi1CFV1TskYQh4ZmOSC4SqnGwdpmjg0oUL5LO8G/ZQN
5+R5vpcPTtTrF3Xgjk5tPxOdVTMBXwllDijjmxDnRxzfbH9yeKL9CaH9ueMr1C/l53GW+iU5IqX/
+vyKi3zuE83vU8eOkv3jvORORLTdAKKDDZBtuT3l8RlBmUNK+0OI8oZ9Bse3239LfnT+DKPYbyi/
RZ3/dX6svx3/fru2f153fXlIRsv3CDoOjV9rH95/035a/xOK/rr9V/qP2D91fVXbjyy1v8OyXy7j
+1m1mzDaN+U9S+wzx/4CLIijAO7n3y6Aq8r8+5cL3lLg9vsf1+9/u0Duz9+LMgPQH3kAOOIinehe
hNEIPPJvLiIlX6KRj+2ydBqIMBGN9sGEZpfu+E70g7hB+0vpq8d3ZP5V/bL0KBhpn3R1ToKXkZDa
rXh7Jz3067RLr37qG0ufbFuVG6B0gBUD/VNZYp88bmxxonr4WGr9t+RH6p+Baj+Hld+y8vrI2OtD
hstn+3TyE1I5zohNR+tt9NvCPgwpn9JE/W/sP7bqX1d/hiQ3WL/pc4z2TXlC0m/IPoP2l4hB3A+/
09YGcL/99sf1R3279Y+/rte//5y7G0d/bhTE+XSKkiuSkSS52tjkmJ1upjyTy4NqtQ8ixvj3xpfR
D+KM8fV02h8aX6X+tfkJqVxON+aXK3O+XGK53k7a+CKpXocaot2dk3K6cSc25BAF/C2Zpn6G2D4R
+p5s1227K19S2MccX6P/lrxZ/ziW/fr5iv2G9J9kM007yvwc9c+5vGAfqRyHZLT8Ef+RmDN+I/pr
/ecykv6+/kq2lndlFvuPof5VbROj+mcWth8xfY7Rvu2zVug3ZP8OPoj7xwVlf/n///hDyq+Cu90F
cT6SVQbfNGKIhIv70Dyfy7P0aVCN9kHAuEj64zvRD+JWfNMbGl/rm5SSb86/SLf/8+YXPV8h9rOX
LrBpEOf7VTnwRF1WwQzgCKn9OQzKl/Zpx78N8oS+E74tQ97MH2N5AGdhzP/h+dtbH0h+0D9L+Ynu
9RUhmSX5Vvs+37KPla/0n6eJ+o/aPzDbf5j2H2y/q39E7Z9mv8DNg7ie/Oj8jHTt34M/E0fBWb3r
tquduDyZ2zwyMMklo9Atj/OJO1HNiHESpHq1Z5qYHB9Utf1M6H9v8I6OeREo45sQ54cfH2Z/4ZkT
otv+3PGd/UxL6Fcu33lmY838pn9PebIT0PrP5ZM9Wz0G5m9xXfWRdenVH58hGah3tP0ukvyAfcL4
RDk3vtY8rvtvyY/Vv9R+M+zbIejXm/9VvkPzj22/qL+Kf97g+vL4ca2CAQb1Qbx+rPbjfFnnP7T+
p/S+/qr9q/m9xH9YQcrQ+C+2v2W/qUxP3rOifaKbb9ln0P7d65sHce6zf/6tCtDu8ExcVI4meoHQ
EdfB9K22NBg5IrfApzx6MDANxsAkeztVb47wt1u4PJMrB01pP9Nzsi+ANAYS4vga8yPWXb/9VdSr
tT84vvrbqVxH5wj4/CFYv5r5xRH7T+jzq56/jSNS7e/q5vJOf/ntKGX+kt2yfESZ57LD69Tvda/q
dhTyM9tvUOVH7MPnh307pO2/JT9S/0L7jdjXJLbtZYX57/JH/aMUZKn+mVh9fQW4jhQU5Dz1+nFo
7UfZ2j+Vuun2M/sf6epv2H+V/5Dy6Hoq9BsZ/xX2p0BXnX89n1PSt58hv9I+pv09neu7CuL8m6hN
kLbZ26ngVRm5gG7Jo9t/NK/efwDWsOr6MQOQ/fN0/rsJIm/Li/hXMRG8Ao92Ygdwoqt49f4DsIa1
18+zX3/P6L/vGcS9jn8VEwEAAIDj8jqL/H64807ciyAmAgAAAACAPZMfFjS+kSx5dR68Nn7ODM4v
AAAAAMzG/cG2MrglmF8AAADALXB/sMi+JvR8Qt4p+3W90Cvy4ivUK1k6vyr9vI71EQBv9Ao72/Hj
fVjQP2nHmc4HEl8zb/Sj3+Cc8/o9AAAAsAr3B4vNa+KDkGncQ7DSP1RxMauCOC4XzuOZXhlPh4Sy
V8jpQMlzfHB2dv9SfVOaD+p48KfU7wNKJ5/1w3UFAADgtrg/2mLjF6q40yA+E9ceFli+eVLns52U
1K5fXGMb1W5JsQviFmDpMM9u/ayMeBjfq1MHIY5iJ0qaFyTD7eiDGm38qcxWQdyAfhxLvqbuWzqR
vRf0rdUPAAAAWIf7M7DY9BY/OkyPFr4UeNHPduSfIUn5Ti4sjNVOim+XB14UkIXyQT4uork+yndt
+X8H1PozCOJEhCCkCGSkeVEFOnRC+SkH1s7OxfhFlgYztX4UMAo7cXSblHRoxtbqX0GYI8Wp9Jbe
Qv0I4gAAANwR92dgsZGDOGOnQsrni6hvV8lPizT9fpnYhlE/0BGCkHZ8lHwJKX9pMOP1c0EhY+iZ
uEJ+UP8Bvf014NuJc66uH7dTAQAA3Bf3Z2CxEYM4S87nTwvwtNDOCBJcGVqkQz3VbxNa9QMdK8gZ
GZ93V4Z2OTX7S/WM0OhX79TWVDuBVv8ywi4cIerNvjj4+lm/XTpebAAAAHBH3J+BxWb5TpxS70iQ
wKDn48pF2agf6AhBjnk7sBifsPNUPKcojd/SYEbQT0zj8PaFsuI87tYpzW+WZumCIA4AAMBtoT9p
MW4yM3IQN/eZuJB/TrsVVpDg8qnsJNsummr9GTwTJ1LZs317M8yL6fZgeCZtsmMMaNJ4N/kJe36J
NOP9dn2necjnB4191lffieu9nUpzqH2OMuDnffF2qmsTQRwAAIB9EP/hFzi3APJFOwU/MX2iWlhn
vZ06BXxmEOd4O5VvrtYLsFo/K4MgTsAHIdG2ZLvqzeBUhtufXmTQxqfOl+rpBUwNlX5e1tXNdfSB
GZujxfwb6d9AoFX00QVw+YuFr1+R9XVP7WeEL0MAAADAAsREAF4CbRcOAAAA2DliIgDHB7c7AQAA
PDdiIgAAAAAA2DdiIgAAAAAA2DdVAj2svcMXAHpvx27Fret/RbxN8wP9uG0JQA/4HwDAQqqEnQZx
4InBs2cAAADALagSjhjEWUdBvDR0tho/omU6c28znjaIk4/YyW+z+nnF86pfbIjYx+R0GKx/NY+6
PmL/ireDKQ1fIgEAYJQq4YhO9FGL1BNQHpYcgpbNj9x4+p24jl3qeVX/dqqjPSzYlRkNxAbq34RH
XR++XQpOWduUhiAOAABGcQtD3m24XE/NYa31YbrlTk04BX+SL36CyWMdBhzP6nLpkx7sdP/s6B31
MyMxOCCd80GyXD+fP9Up1qPV71F2qlJwwm0gHSgbg4D9LU4UFFS/YMAXUSn44vm+zHtlH6GPahBn
Hxat29/NOZ9Ph/Cm8Y67XVZ+0Y7GYBDnKJ9tEuw7B7N+YmB+5rKOZnyDXEFVv3b9E+r1qxH7d+Zn
9c2ZX0Pju7X/mtP/dvyb8fM2iHKF3RP29WHpBwA4MMVODDnMKtjQd2qik8oOmxzKqVg0vLyrLwU2
9c9y5TK+ntqBTogP/qZFqNJ/ZLGtEet3SPbJ9cf2J8dJ/Q/ly3p2GsRJizxPk/KrRZZ+oWEaNwoo
hP5L9USs+WHbPyySfvxiGyTjy1j5VMcQC4M4pd9D1PW7/lOgwAMk2z5V+9X45bSOnkX9HTv4Msb1
K5LaJT2TTpV+6vwaGF9d/0H/taL/XJckLwW4qv8ZvT46+gEADoy6E2Pt1Ph8chrOifAyGUFeoHR0
MqKTY048p1WLQE7rLFIJ2Yka/R9tf69IizxPk/Kt/kn5Uj0ea36M2D/Wy9LzfLLyKX2IzuJIdfJ+
UZDlr4dYrtvvQXz9FCAk6p2iGfaR8nmaqKdRf2S+PSO5XRbcSPpxeL45vpb+abxm+C9BP7X/PX0r
hv2PlS/oBwA4MKqT906HLyIR7iRcmfPlEsvRLQ3mzBSnxRlZBPpBnKI/TzP0WFT/aPt7RdKfp430
792VcQtwd34QUj1aesJqn+ez9DyfrHxKH0IL4njfqxcPrP5Z+PoneT9HeX1z7CPl8zRJTy/P+xep
5OfbM8LbTXrV+mnzyxrfEf1dGd1/VbIEl3fo/Z8CLTlQCwz7H86gfgCAA2N/U1WcSIV3wEV565tk
YGQR6Du5gW+ijV4tsoM1vulKTlZqf7es7R/J0w4KGzup/93FyJofM/Rj6eUiruRT+hCDO3ENVv8M
mvprPdaOH0sT+0H1a/0LzLdnpGg37saduX7UvjK/zPEd0z8h+6/1/Q/54VZ371nBYf/T5I/3DwBw
QMjBkPMITjE4Gu7ki3wHPZOR365zTpT+PeXVTjDKu/qsZ+KsRaAfxLX6N3X5cvpiKjvRqv9LnzmK
C1Sb/njK8ZWCBN7fen7ERSaNpzB/eD3SAmbNj2H7S4u4lU/pQywN4uK82urtVCFNtY85fhHl+ijq
dxTXPyszz56Rqi/eVnQ9Z/2M+TUwvqr+Tn7If63tv6/X1VOPJUP1P65fY8/EyfoBAA5NDDC8k3EO
03w7dXIohH0GVis/1R3oO0GuGyc6w+jEu2+nMrgOk7M06k9lem9/8UUkwRaTnJbaadL3QNm/RkfX
Hz6+9KA5L1OPf50v1VOOtTU/Bu3P7J7n08AiryPPjyxLddbjL7DunLi6/iow0+xDMLtr4yNfH4R+
/QfZUXtWNP0LfRueX0Pju73/mt//2K/CroQ8v2r/Y10fln4AgEMjJj4HUhAFFhN2QvQdSwAAAADs
BjHxOUAQtzn0rb733A4AAAAAdoWY+BwgiAMAAADA6yImAgAAAACAfSMmbgN2ykCk9/YdmAl7gP+e
1xfGTwf22QjM70x4Rll62aUF8++lERO3AUEcANvyoEUOgLuA+d0COwAdMXEedOFJkwyTb9/4cXPf
8vg3OD9mLi05UrAOOhfuwr5R0zEZa97+xSIHjswLzm9/tl8+aqb61RAC1znQERPngSDuOfHjdrle
KLCIabQtf6GgA0HcBoTzwYpfHKADa5uzvmaAIA4cmVeb39EHn5KP8H2ujnnCdQ5U/KIy7RQUh0lK
k6e5yNI3CEba2UnyTqY4sLPYiTAOK3X4wzSdXtO3lfr0/3hoJgKPeXgHQocl029+khOhoCN8nsZ4
YH5o4+vbiHnNMxvUXumwmmc71rQ/ot/a/mkkeSkvobXvoZ282DbZSjrsdmn/HPQrBVnW1V/+wL7D
5SfZ24yfa9Pn0w4EfaZyMw5Ergi7GvGYnJH6147/ze2jtL92/EfkDcz5Y8y/157fVH/7SzbN4dHJ
DqxMRtN/A/sR+vprr986a9d/fmB2OX/8hoSTe3+rxvxo0Ano+VuAN6gzRpoM0uShSVMHS34iCZPM
y/OBodPFWf2O9Nnn04RyA1Kffu7L0ADVF2AGQdwi0rjROJHt6DONBTmqaEt7fujjm2icX8RfoHm8
wzhyp7aq/ZH5t1H/ZIKTpp1OaiPUUaK2T/nxs5eN10e5yK3oX1qkmEN8J6cXZTm3G7+wSPr6ow8p
6xwgLkTeFtHWId2uf6vxf935rc8fff4F+9Bn3/6rzW++brq+hyAlBn1cF19PLNdB1H+1/WIZSvN2
TOWqvFR/Z/3WGJGf2/4UBzifm29VUxDtyvEA9jhUCTxIkyYPz+dp0iRjk7gom+XjRdbND9BAzZkY
YJA8buSc6DZqcFDeIdRjzGWK+WGPH9Fzkm19urOa1f4M/cT8JfI13jmTAydHQg5mRv+s62Nt/3z9
dG3Zzu124xfLs/TR650cNM1Zsik5+KbPS+pv9Buz72vO7/H5kynqf+35zdtMwYgUaI20K+q/2n6B
/vVijJ/JmPw27Tu7uoA1+wtjPjwXyRGmRYZIRpAmj2QkSpMmmSU/WH9/EMEq+Lixf3uHkMZgi/nh
6DpJdiGKZda0P6LfRv0bQ/im+8j+Ea4OCjLpG3v4tipfZzcfP6b36PW+SRC30fi/7Px2dajz55H9
Iyz9Io+Y31N95Q5f045khwpRty3s5+hejyP1awzKb9P+gYO4cE+eGYgbYdRIlFaXI0z5sUh61KmD
mXTGzTsEPwY0PhvMD4foZCJhfMNWOL9VEebHivaH5t82/RtmTvvW9bG2fxX+dnpdX8q79fix9NnX
O91G6d5O1erfbvwxv6X5Y80/yn/d+T352ZAW2t96J269/ZK+uUzGGD+TMfnl7TsbuyD18LdTvRHS
xGzuKYdBzgZs8pMcTZbKmDldm0TT5PWfY/31gPUHMRG+yTR6AR0aC8E5TM4lXiS9+TEwvgnNSQY9
XL2NLivbH3Ji2/RPxMmfaW7n66LeiTPad0jXx5b9844tyi5d5DYZP6a3fb33aV9s0OrfbvyPPb87
/tXJ6/PHaN/x0vOb6+Nku8/E+XbqALJE1H+t/SLa9SiNX1u2vz6PyM9tP7VDNnmJFxveaIvRT1Dq
vBtw97kwtht0NT9CP5weJrojTSZzEhG0sE2y00OYE9ogBhDELYI7EYZ3CPlCUMbfHN84Lkk+U7cZ
nFTjhByr2h+Yf+v6Z0MLB79dUb/9ZV5/hQ2dw52pn1V/nV9+Ebvj+DG97et9kIH6143/q8zvvn/V
54/RvueV53dof2iuO/nUzlTe0H8D+xH69eh0MNbvrGdVb85btf4zG9D4Cvq/AGIiAAAAAG6JD7Ro
53ggkAM24peQwyMmAgAAAODW+FupbDdqZGcOBOjxiRwAh125F7SfmAgAAAAAsGPoRRDrdu7hERMB
AAAAAMC+EROfAv8AfozA24dRAQAAAAAOjZj4XEhv4QAAAAAAHBsx8blAELec6qFa/5p5eg3fsiu9
CZR3Qif4eUbFbmnz1hB7PTwzcxw1/Rv9Llc6tLOpIxHL48FiAAAAT4KY+FwgiFtIOP+oeL2dDkxM
Z5kNBXGDdhdf/V77NpGhf60fBXy9II366gLA81ZnlAEAAAC3xh9G6ncpwk5FuSAKi3i1GKvyHvvt
EX+Yn1t4w4nVgWk3Z+DtEzXYMOT9os/zy0Bji/6lYGV359dYQdreg7gF+oknm3s9aGytgyUBAACA
HVH87IYPSE7TomcGcbSzocg7aFGkRTOUlxdtX8bX0y6eI/LaYm7J0wnVU7suP5YPn7fpX0rfXRAX
d7LS7002ut0piEsBsA+SZwVQhv6DQRylpTGj8WzHDwAAANgh4faSC0Kqn0vxDAVxinwKgniesJj3
F84x+X6wMSjPuUH/do30TFnOGwnieBBGVPbgZQ270O9e0q6n9huBDZr+Xj/enzSebK5RH5leCOIA
AAA8D24Ro0Uw3DKsdkLMIC6U0eXj4sqpFvPuwjkoL+qZ0w15ChyK3aAqf4P+PQ/VTmTProk6SNIY
COKIdqes3K3TA6xKf6/fJEvjV77YEAJAHnQiiAMAAPBETB/o+a9y50JYxJXFuJH3O1X2Iq/vxA0E
Cd1gw5IPOzPFc2436N9Twfu/iyBuJrwdS79eEE4M6AoAAAA8lDPdKowf5CCFBVj0EgB/tsstgrp8
CNBoUZ7KBJmUn8r0dj9G5KdgjKcFdHmSu0zPvN2of3k3aW+BAfWPdM87UXfeiavsG9qbcTvV0n+O
fhFtLgIAAAC74u3E3r6kB8Tr55ncQsjz6UUAvhib8m5hLd/ePE3neEX0hdOW9zA9y7p0+Vr/W/TP
Bxd7DOIcFJjy28nF27kxqEp5mSJIavML+0tlsh2c7bh96Xa18HKLhqq/bxtBHAAAgMMiJgIAAAAA
gH0jJgIAAAAAgH0jJgIAAAAAgH0jJgIAAAAAgH0jJh6O1UdXAAAAAADsCzERAAAAAADsGzERvBDd
Y1Q6R4i057gpR6j4n8VKsvUvJgR4+xc69204P7Yb8wLsSBFB/3n1OzT919qnkqffgJWOz+kfc2P0
38tOx9/Y40P9F8okor78CBazfo8yP0QbTr+i4Y+QYenSETR9+wAAwOERE8GL4BdhHjzQop4CFb/A
Dpyz5s+To58mq383NSze06IfPvMgp26fDkvOhy+b+XX9FY3+bfl59Vf6r7VPJR8ClrKMOj5W/znU
VhNERfkcuIbP4mMH1Aenx7l3jp5Yf6Q7PxyGXHGYs69Hnz+lfQAA4OCMfNP1B6C6b+j8G/vkSNvD
bieH7ByqtCgVi0Qt3+6UaO2b+tMikfKlxYkWrl77ftFwCwRvgy8YvA7SrbsTsVfa8SnwtpuCjB5p
TJuDcpP9WNly0ab2y0W5xMo3ghhB/3L+GfVb+q+1z5B+yvhY/ecUdk+0/W+vT4LaoWtLOQxZrD/Q
7T+hyEmUdVj2AQCAg1P87JRz1u8uWKoXJXKc/hZHJ8AjJyzvZNRONyw6fNHw8s7BBycuL0r99qMT
N/Qn5MWpat99iy/aj9/8+U5FKl/WE/SesxjtAilI4QwFKWxM6wXZCoJi/smlpSC5+BJg5Se7xzwf
xPO5U+svjq/dflf/un4RxT6SPC8jtV9g9J9Ttx3x16dx/dG1k9J8eamNTv1q/4munASriz6b9gEA
gIND38TpOZ/p9ydbuo575JuwuigJ8oJT19u39SfkIM5o3+tr6/e0WIsg9TUHCFOgUNijqKO2Zx0U
pKAjlveycfxSPg+SrfwK+gJB5fMiL+jf7rRq9Rv6r7WPl6/sz+dXIWvT9J/D6y2gPrtrI+rf7IST
DkxudhCn9Z+QbNgZX2q7yJtpHwAAOB7OEZ4v9LwKOVD5m3zXcQ850clxN4GUl2fOO1EtBv0gzjGg
PyEGcZL+1iLaXQyfEGv8/AKrj6+3a7ZHHfQ4/PikcT1fT6cZ9l1g/2KcG/2rndSR+jX919pHkuft
S/oZiPOcqPvlCfpM14yzTyHvrl13bfGga24QZ86PjlyNf+SiLrfAPgAAcDCmD/R8mbQo9YMo4Zu1
QJAPt7LKXQKSt52wGsQxevr7PHFx6+wMpMViQRDxXBjjp9gz4YOiFHwnpCAiUo6DMP6Ffa38lqJ+
Sf8i7Qb1V6j2EeRb+9jXF0ee5w6pX9L85mn+34L+RF1Xx27m/DDsTYgBnGe+fQAA4FDQm1zJOc4P
4qKTdg6290ycx9dLDlyum5z6pMPpWr9d1m3fLTIj+vu8zuJWtN95ZqqoT1x0wg6DtRjtEW+X3tt9
ij0DwiJaybydyrlR3+4LY5vG0NkxjsdQfjX+Kegob6dy/eNOExsnq31V/7X2qW3lPs96O9XqP4fa
auYn6efK52urtU9N91rs1q/PD1kuEXdOFX1U+wAAwNEZOWOp67g95GidI411lA+eJ8JiIQVRknx2
yBGtfV3/GFyl/AxbRKhM75mgFwjiiK4N/YIb0xl5LOoF2RMDgxxIuM9pDOjWXPNySm1/wbbdfAo6
mO4uYCjeThb0p+e7yvllta/ov9Y+lfySc+LU/hOSjnyeUiDIr5GODonmWtTqt/qfyvSumxiU1vXX
vgDnxAEAXhgxEQAAAAAA7BsxEQAAAAAA7BsxEQAAAAAA7BsxEQAAAAAA7JsqQXvQeA/sXT8AAAAA
gPtQJSCIAwAAAAB4BqoEBHEAAAAAAM9AlYAgDgAAAADgGWCHmdLp6qc6SKoP420PwyWZdNhm8wPa
A/LvLjDjh3WWh43q+oVT7qf85rBTz3MfxgsAAAAA0OB/1iYFVvFnp3iwU+THYCifmJ5OVK/k+Ynq
I/JTYEcBXygvyjf60envdIp+KBvkT9UJ8SG97hcAAAAAwFMj/rZhHST18n0Q9kB5n09BoQvyeBkA
AAAAgKOj/jZo2mmrKfJvLa/kxzLnyyW2c2E/5g0AAAAAcGDsna4qiOL4IGutvBakWTtxJfR8XPuD
2wAAAAAAB2TeM3EUKJ2u51N8Zs0HYa18/5k4SV7faVP1o104upUay/aDODwTBwAAAIDDEQOceDvS
fjv1NL09GoOweW+ntvJaEGfp98bapjdbi127DII4AAAAABwOMXEMKQgDAAAAAAD3QEwcA0EcAAAA
AMCjEBPHQBAHAAAAAPAoxEQAAAAAALBvxMRd8HaaXoiwjg7xZc/TLz0AAAAAABwcMXFf4LYtAAAA
AECNmDiPWx+yiyDuJvjdy/rYFW/r6oBlAAAAAOwRMXEeCOKelHB+3nQ4c/0ZAAAAADsm/CoCHcJ7
zofq/rqe31OB+rBedpivD64mmUx6Ni0GX9ZhwKde/QktiPMBZNVuIsm5MvxA4HzYsEfpHytz2MOC
eQB+62AcAAAAAFsSf9qKbqG9tzsw5c9mdXZqeot/CvKSvPWzXEL+VI8eXIgvNsT2p8CMArbQXioz
1L8jB3GOYIPz9exsNQXvAAAAANg5YRGXb6EN/gC9GsRp8oP1rwriNmj/8JAdyuAWAAAAALtHCeLi
Tla+XZmYFcRV6TxIsvITq4I4q/2B/h2e3g4kAAAAAHaMtROnB08eNYh79E6cEsSN9u/wIIgDAAAA
nhAtiEvPS6Vnxlyw9H66nk8Dty1zOpNf+kxcvN2nPa+1LIgb7N/Bn4lDEAcAAAA8JXoQRwt8+fbm
qXq7M8DL5GAqBlGr304lXPCV68i6xuAqpk/EwG0giBvrH4I4AAAAAOwOMXEbpCAKAAAAAABsgZi4
DQjiAAAAAABuhZi4DQjiAAAAAABuhZgIAAAAAAD2jZgIAAAAAAD2jZgIAAAAAAD2jZgIAAAAAAD2
jZgIAAAAAAD2jH97lB2k++viPvPDbulXFKrDcPOBt/7t08v17PPd/0/0mcqd2a831IfpSof5Hv0w
3Z2S3h5Wxv+N59EYv+NAYAAAAGAX0AI9BVYUcLnFOv3iguP95AKyvHDTryuw/BjEUcDmf/YqHifC
fwGi/Fmr3i8DIIh7CH78tPGPv22bf+6M8k84MgYAAADYA/oP1AvwfH4OHEufgrjBH7gHj4EF4Tmt
GJ/wm7WXkwvyeBkAAAAAPJ7mMN46yHp3Cz3tkuVbamzHzAri4k5PIcvlwWPh45eox9+VOV8ucRzp
lnm9iwoAAACAh6Av4mEnpngOiudbQZyXr+oH+2EkiGPQ83HplnmdBwAAAIA7Ywdx7JkoesmBP7tm
BnH1M3EUCJyu59P0zF0Az8Q9BCuIo104upUa8xDEAQAAADvC2ol5O1VvLrrPc4K48DB8+XZr8fZr
LIMg7gEM7MTV4188PwcAAACARyImAgAAAACAfSMmAgAAAACAfSMmAgAAAACAfSMmAgAAAACAfSMm
Ph3+FyPyLw0AAB5C9WLMMPQmdDqPcqMXnMKvyMQ68VY1GGHp/F3AQ+bnHfsn8uj2Ozx5/CAmAgDA
fBY66fKN9o2R3sIGQOIRQcY95yeCuCMiJoKXIB7tkr8Nzv9GWHybtC5OuoBduTmLtfUD/LPaF9Dl
R+zjyuQjdIxftBD7b8nPqF/AtJ+RPxvq4+xxCHY+59/o3RhrkfTjsnARfXv3v2gS7OegY5jSMTxx
vItv+F4XKudslPIzFzc3XvBuwhr7b82i+bsSBHFgHWIieAnC4rnJDoh1cZKjcgvcec6Oi5M500HR
aVGMC6C42K91DqK8bZ9wmHWUowW9p1+n/5b8cP0Slv3m2HeURePwrEFcGg82P+hA9DRevl4XmFFg
F/PpS8OFgj6yUd1uHN9NrsdnYrH9b8Ci+bsSa35uySP6x3l0+0ek/oH69t5wfVjvdIJ/wt8KcY4r
P9PiHZvL85PTfbv38rSLEBYJumBzm97p8frrAQ4OPuQ7Xflhw4R3ADG/0DvRHjbcTqDYxstNrnsF
cdQO7fKsv23WlV/rHER5yz606FrXD9HrvyU/Wv84lv3nj4/TUbs+Xd/7/iNedzEvw+U1/yAtftI4
9hZJn161TYza11p8vW9yvo4CN29TGs/w2esY87n8rPGN7ZPNUz9m+Wefb/l3Jd+3r/h3S79N7K+0
78u5Oab2z5q/CrF/3fmX8l1a7iffqU1I9WQM/c31c23/bmlfuh4s/7Yi/nB55p0Gfw3G/KLdhNK/
gfHd/E6HROm0g1OdLvBgIOpcUDzk107el6HBqBWMk4AGyQ9OnKi8TfoFiEmODBbaS3UU7dOEpYES
JmHP+Xl5Vz4Zln72K/+MWCb0a3hyH4bYbz7JZi3gDLoYOvajscnjzcZ+Pu38zCjtDyHKG/aRnK9Q
T7f/lvxg/eMo9hvKb7GuzyI/1t+Of79d1T+M2kcqxyEZLb8LLUKuP85xk47NmKR6qX3SiT6TLchX
pc9Vuz0/JuL71dq/tq8fA8k/pzxlfNR8377i3wf1W2x/q/34b619KX/4+vLtV3pTX5J87P+08FNA
Etoz64mY+m+0forcwb68rjS/Nos/UpCY6yP7u1igKBPoXXdq/8zxHW9/Hc2k45OpjZSL8pFyIBi8
PibXLU8U9Y+1T8iDIMiDLhTg0qScs4hnOuPi5wBLV8feoLxAKnrtjzIg39gnz2/mXKgefg1p/bfk
R+qfgWo/h5XfYl2fo9dv67y7cPlsn05+QirHWWFTcuzNM3EpL9dL/aPbqKGP3leRjnW7VBctCqPX
h+/XCv+8dvy4XVl6bm9QP5+2xP5W+5vNzw7SvOLyo/2X6vEs0O9W/WNym9qXf27sMKa/Pr8pzwVZ
vA6B4fih0dfq/1j7K5kUbTrilYzOiTNqRHMSULor45ybWH8zqGU9Oc0hDoIkD1TkyTyAOC5ubrnF
i0/y/gWn47fUhXHPdOZFChDS3Oq23ZUvKexjzk+j/5b8jPlvYdmvn6/Yb0j/STbTtKMEcVv4B6kc
h2S0/GFcP9z45vnB62X/9nOIdPRpvG+0Yzvj2hvsv+6fefuRwr5WPutfTM/tDepX2GkOa9sf1a/H
VvVL5XrptfxG66cIl2dy29r3hvEH4eogHxzq6d9pGo4f5vZvsP2VJCOErcLSkZKBKyUFukbknZQm
ga+f2mSyhRGmAZbzJ+TgQ5AHKrIdB5DGxY8/u/g4whj2MAM4ojMvhhmUL+3Tzq8i3+y/IW/mj7E8
gLOwrk/Kt/1HP4gjecU/jDhRQirHIZkhPQfg7Xfq9WNIZda26/ul2T/QX+Ss8THyuV1Zu7m9Qf16
djKx2h+anwP69ZDmFZe38hNSOc+I/tusnyJ3sm+o7wbxR4V2vcl+1dB/dHwjq6/3Pu6Pr5wWl7YB
MhB1LilFt5TO1bfFrhFHJ0EauM4989y+kJ/oLW5e3pXHM3ECbnxoLHOf/XhJi+mAfZTJy5HnSq/+
+IzByLgMtt9Fkh+wT5ifUS7eDmvtN1H335Ifq3+p/WbYt0PQr399FvkOyX8k/dt+Wf4h2CPbU2h/
qkcZFz+ulbMegeYH9S3LuX7E/vrP3q+2PnXbII7ZN/a/vr5oDNprbsrTxkfN9+0r/n1QvzX219eX
Sn+hfSm/nT89jPnH9UtIfkaZn7r+1vWxsn/3sq+/Dly6cC0U8o658Qf33/ODOKN/1vjOaH8l9CdM
IqkTwdG7Dnojuw7Qg3nVxaYZ0ZoEb6fqzY7i7RUiLlAxv3y7heUVcEO1+k91T2XEyXV4nG24/Z1D
kN+eUeyTL0CGYkd5rnTq9/OnqttRyM9sv0GVH7GP0z3PL3u7vO2/JT9S/0L7jdjXJLbtZd2CIly/
lv9IdUiLmOkf3Pip+UI5qX9cR9kPypBj5rezCv/i5xb3RVFm0yAu+MTcN7bgJbr+2WONj5Jv+fdB
/YhF9rfa9+X49SO1b81fAxr/pHc9/7h+rLxYP6unHCtd/1nr59z+3c2+N4o/HLV9yi8KXDcOHzOl
fwPjq7e/GWLifuldBAAA8EpIi8ie2Lt+ABwDMXE/0PZp3v0IkXMv6gYAgJcBQRwAQEjYGfV2qrwd
DwAALwWCuBsSb/H1wN0gsB/ERPAE/O9//6ciyQAAAADgIFz/++8a+Hb9VypwQ758/Yhtd9r/9PX6
8wF6PQtS4MaRZAAAAABwGNyfRwdLvfZfJoj7dP3+8XH9/sn9m/r88fX6RSxXIgVuHEkGAAAAAIfB
/Xn1IO7zt4fsRE58vv6I7fvdyW+fhTItUuDGkWQAAAAAcBjcHwRxjw3iqJ9x9+3fb/9df3wWyghI
gRtHkgEAAADAYXB/1GDp0/X7t+nZtZ/fPle3+j65wIPnV7cCP32u5IVbhVYQ54Ksn1H++uE+023H
XE7X7wuX/e/DBUifJllff8pjNDthdLvTpQ/e5hzGB49V2wnXlijDkAI3jiQDAAAAgMPg/ihBHO0M
UVDjgxcKyFww8/PrFAj5fBdwpMDqy+ev1+9sJ+nfr9/c51SeAq5QX8r3qEEcD8woYCzldf3oNuUH
04fkna5RNmPuxN0oiIvk3Tfq74w2pMCNI8kAAAAA4Aj8dv1/Dw+WRzpKcqIAAAAASUVORK5CYII=

--_003_DM5P101MB0237E3ED4786464058E592E6EB079DM5P101MB0237NAMP_
Content-Type: image/png; name="2.PNG"
Content-Description: 2.PNG
Content-Disposition: attachment; filename="2.PNG"; size=13436;
	creation-date="Wed, 16 Nov 2022 10:46:49 GMT";
	modification-date="Wed, 16 Nov 2022 10:53:00 GMT"
Content-Transfer-Encoding: base64

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
3xH76ODWb+C1r0n1P/bxbWx+muj+WPageLn9UzPQ/xWzPjv7V5cB+5E21PeeLUmee/wt6lf9Vt9b
/V/r31lfg+tjKbvfNiqWhlcbV5y0yVgKqk51F22o43wJkWqUbUf67U2zUrBWipcPfUb0J4YcDd2Y
f0teE/Ol/PRL58pgbzS/uw8auX81G9v3mTaL1oJt9n+LflS6q4+MVX+De6/PWH93g+zQHUdnfzMY
KWMyaBe760+U8smu5rl+u76v6s8HqonCLobm56h8J92Vd8bnyoe5D8cebVPl2rhz/VF+0d1Mlvfq
Pzw+hVWXh9v+VOZhj+8j8l/5+CaENkbmpw37Z3P/0zT7f3T/PCI/vj/ES9Ss/vfWhxDtK6dPl4ra
epgo9G/1XxPzVbsZs59j9jNIVtR06q1c2LIgOp1OuIs2Ide3NqNI09iXBTmn6cEPGRU0ifrr6Dfq
X2xCze0qv5LX6Prj3Fdlh9rv5U/sP2h49j3Wvk/afLcGRV772v5V+uh6NNdPA3N9WvKt/ln5mVTu
JG1s1q3Qt8P2/rZm90F30C52159wDyob5tTS27b+ja6Pyf7XNrnBvjNFmtP/WNY4qArSxo761/0z
6hZiGZHvzYXTf0t+U/uL3C67s/TTsfPNx3e3fkf/HrH+nrzU/5WPbyW9+enB/jnAYP9L1vO/bXyO
/cSxGHuDoPraDIjc9bHG63+Z76yvmD8yF63jy27CR1wsoqx1B2RByCCyEuQU2DkskLqM2aEwKVJ2
kZV27EG2lFm0X19zaxmwOWkp2u5M5kuSF01Lv9lo80ZoXLMa5yd896651mXnOXDbd+ZflTHtL1P1
Q1PUH6jt22p/ux3tDYqc8Wv7V3bv6iOj5R3M9WnJF+tv2lSX/lr6yxvv9D2Pd65vkO6YW/tb6L/e
n6bxWPM0sH9Y+87R+l35pLt53OmXzl4/KyZ9p/JhfvRcjGDZpzWOofW3kvfHt7X/pZ2M1u+MT1HW
X8kH7P2l3f+pviwf7CTVl/Nr6va99D5Tf2a5evyVfd4+KKr0N6D/grReavly/r/w8S2kj85PF/ZP
H6v/A0zzn+TC/Hv7V41lP71+lLYUxivyzfL++ng7lWuj0O/A/OX2x+4pmvKlzpwfifXax5edyMc0
GdJ4lRkQxQVDkfyA3OiZB5ApFV2i37EQT68VssmYc/6MXnxyINDt10rub6pzHd6ifEWS/uqn4+gy
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

--_003_DM5P101MB0237E3ED4786464058E592E6EB079DM5P101MB0237NAMP_--
