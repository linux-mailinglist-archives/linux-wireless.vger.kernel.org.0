Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5962A68D3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 16:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgKDP4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 10:56:33 -0500
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:6126
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730977AbgKDP41 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 10:56:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj3ftix9KhPYDjOoqrs3suzyn+K/ZpuiSVctj3J+4vNaXkIcPQQ9M2csSnm4jeEt5nqFTDrt4XMktvoAa0aS+yzLg+0uP7c6w95pGTtcO9oLSxQ34UbaDxeUJW2mdb9Z3zDjZhBDAsLSk/DZUCs4HqeP0g+59KSq3kbuFTJKe6INuWEKGRLpDL4XuHcXOmmAkDN2az0X+Mt/VxE71Id6zK4HP8wPtiEkyZJx3ZqqE4MLY0yOBADbTRcH5sS2MOvDbpbY63jFkLgapXYChdn4ag6gkUECa7krUOEVpJ+yfhXtPg+Ji5ogrLD5xEJByOaKCbRQkWEkhxnwWR0sazEDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJe6Sy6mxOMEzb8LjIqDJlH42l1rhbHuYENIx/3Vvmg=;
 b=fwvBLGd3840dSeFqcurnibVK8Cjih1GHeblCrkvh2RO0q2W0FCxXnucy5I2lz4S/rZCzV2xx5uWvX+4gIdqcCArlRylm8NS/Rl4I5DCd4wXTJSvYGED5ZoR9IcmI+qFzmfjslY7RTVpDgMiUdlWzLuhxcaGP9RkOm6cdLh6yB54A1JBdcXFCAtKfAOVLxaAl5eLXOAqP0wTPKLTzV0he4nEqJHyc33RIWKD2vmNpIgdNNz/43zm81midtIh0H5IU/tOxpAzNNEElw30xuv+jEX5neAUXXOguAqbmdrplD1lM9dSpNVe8K4INzFHPorb//gIlO7h8LXw97zvft1J8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJe6Sy6mxOMEzb8LjIqDJlH42l1rhbHuYENIx/3Vvmg=;
 b=FTHyydQ5o+tE8So4/o6kFuD0L5MS2mpOIhh1+MKkzxj7eRhrRzDPvj+sY62IzSO8n3Z/Na2KRHXXjT7MvRHQG2VN4b/5eoF18eBIl4ca1UXcxK3MDrJVaU7wUcVREa9huKc2lNBWkmxFiuFmiWMXm8GU1MOyGl2qq01y0TfcJKo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32; Wed, 4 Nov
 2020 15:52:38 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a%5]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:37 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 07/24] wfx: add bus_spi.c
Date:   Wed,  4 Nov 2020 16:51:50 +0100
Message-Id: <20201104155207.128076-8-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104155207.128076-1-Jerome.Pouiller@silabs.com>
References: <20201104155207.128076-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [82.67.86.106]
X-ClientProxiedBy: SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45)
 To SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (82.67.86.106) by SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da71216f-5c2b-40e1-3ac7-08d880d9a742
X-MS-TrafficTypeDiagnostic: SN6PR11MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB27188BA6D011A665783025D593EF0@SN6PR11MB2718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qQPF8UHq81yuGP+cUTPjiSeYX5Ot9AUVq0uPRM0MpDMg8Q9F8rTireAjPqIVIZ3a44lRcRCmkTamoANMFukhvpNXLlHIl95Y7hjLcfrimGEcVsr4BtUuaoAlTQeVcKbIzDmn7EuVJTK6h4TbVNtOZdld0Q2wKE0hRxebP99kkPi9sxsjLzKQWdfJDJwtdVFnQqDLyAmNPXI0o4vVDdK1rGZ+FDql4VjXNjwyLA2kUg+NrcOpRDNL8QVBPkej2gjp4A/kWZlA0p91wwO7geInnSYv1GzHXhnDmVI6ykhC7yV6R/efNoakvn7GdGbdmv33tHx4ncdwts3fYo2RBYEmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39850400004)(136003)(396003)(8936002)(478600001)(186003)(16526019)(956004)(2616005)(6486002)(8676002)(66574015)(66476007)(66556008)(66946007)(316002)(7696005)(6666004)(83380400001)(26005)(54906003)(107886003)(36756003)(52116002)(7416002)(4326008)(5660300002)(86362001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W5B4QMByRmf0ByzKptF/N2Re+0cobKNID2h3d7XdMOZN9gYOZpNhEwo6+8+ZMU2MSrC3sv9sVkZizUMwb43x57L/PRJwNP9BFZLFvrW0jWLNh7UAJZsOZkLEI8oI09jMYa7kR26lAIFtBaF/Yqh9+7X1Ri140y02+yyilkFGP15sphT1uBvSk9UtI5BHT5sABPyHpG1hJN5p0LTSqyOkFd+FBLz7vFtBpOJjEgpGz7j/5iQIqFNZlpNOE9FCduZiWtXeL/hETIgLYvqsrGQzXDfG55/h/Hs60Uz7bbS6Mkl18zdZdfkrO84p1VjYg7yoGe7IJMKGMK5NT7gJhyocuOXdS4uwZ2wrqIbKyGbH3D69p7lujT6OVhrgeA7N/zZbyFlk/QITpVekvlJh06Wk7TP+1HU/7de+KqymQttinjrPdTdfRTqBHIV7txVrPEw6gDBTm0JSCZRPD0lWpMt6JlAqnr8Wpxzz8g3ahVGsG7Me/Kb+lc2v/rfomq/VGUF42YEz9DM2qgAacf4dE2QA4ag7l0CH7qhKXNcr4EbXF89AcZSRXl1KVY6fD4Gw03V0UivYQaxQ0Srcu73GPPl+9cdVUzJfwOS3Bd6KndT89dezjMKtmSXR25I3Agh6qY6iwlBq5KOH8nXAjEq42LYEZA==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da71216f-5c2b-40e1-3ac7-08d880d9a742
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:37.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygCqNWCO6gVArDnygdXAz+X+iX6cKv9n4OGZ/nRFc/39TG5PDTlqJKC3CpcumZ7qmzma0ordNjpxkw29VlMzOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2718
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jIHwgMjcxICsr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyNzEgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3Nw
aS5jCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc3Bp
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYwpuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmE5OTEyNWQxYTMwZAotLS0gL2Rldi9udWxs
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCkBAIC0wLDAg
KzEsMjcxIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisvKgor
ICogU1BJIGludGVyZmFjZS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNv
biBMYWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMSwgU2FncmFkIEluYy4K
KyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KKyAqLworI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvZ3Bp
by9jb25zdW1lci5oPgorI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4KKyNpbmNsdWRlIDxsaW51
eC9pbnRlcnJ1cHQuaD4KKyNpbmNsdWRlIDxsaW51eC9pcnEuaD4KKyNpbmNsdWRlIDxsaW51eC9v
Zi5oPgorCisjaW5jbHVkZSAiYnVzLmgiCisjaW5jbHVkZSAid2Z4LmgiCisjaW5jbHVkZSAiaHdp
by5oIgorI2luY2x1ZGUgIm1haW4uaCIKKyNpbmNsdWRlICJiaC5oIgorCisjZGVmaW5lIFNFVF9X
UklURSAweDdGRkYgICAgICAgIC8qIHVzYWdlOiBhbmQgb3BlcmF0aW9uICovCisjZGVmaW5lIFNF
VF9SRUFEIDB4ODAwMCAgICAgICAgIC8qIHVzYWdlOiBvciBvcGVyYXRpb24gKi8KKworI2RlZmlu
ZSBXRlhfUkVTRVRfSU5WRVJURUQgMQorCitzdGF0aWMgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9y
bV9kYXRhIHdmeF9zcGlfcGRhdGEgPSB7CisJLmZpbGVfZncgPSAid2ZtX3dmMjAwIiwKKwkuZmls
ZV9wZHMgPSAid2YyMDAucGRzIiwKKwkudXNlX3Jpc2luZ19jbGsgPSB0cnVlLAorfTsKKworc3Ry
dWN0IHdmeF9zcGlfcHJpdiB7CisJc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmM7CisJc3RydWN0IHdm
eF9kZXYgKmNvcmU7CisJc3RydWN0IGdwaW9fZGVzYyAqZ3Bpb19yZXNldDsKKwlib29sIG5lZWRf
c3dhYjsKK307CisKKy8qCisgKiBXRnggY2hpcCByZWFkIGRhdGEgMTZiaXRzIGF0IHRpbWUgYW5k
IHBsYWNlIHRoZW0gZGlyZWN0bHkgaW50byAobGl0dGxlCisgKiBlbmRpYW4pIENQVSByZWdpc3Rl
ci4gU28sIGNoaXAgZXhwZWN0IGJ5dGUgb3JkZXIgbGlrZSAiQjEgQjAgQjMgQjIiICh3aGlsZQor
ICogTEUgaXMgIkIwIEIxIEIyIEIzIiBhbmQgQkUgaXMgIkIzIEIyIEIxIEIwIikKKyAqCisgKiBB
IGxpdHRsZSBlbmRpYW4gaG9zdCB3aXRoIGJpdHNfcGVyX3dvcmQgPT0gMTYgc2hvdWxkIGRvIHRo
ZSByaWdodCBqb2IKKyAqIG5hdGl2ZWx5LiBUaGUgY29kZSBiZWxvdyB0byBzdXBwb3J0IGJpZyBl
bmRpYW4gaG9zdCBhbmQgY29tbW9ubHkgdXNlZCBTUEkKKyAqIDhiaXRzLgorICovCitzdGF0aWMg
aW50IHdmeF9zcGlfY29weV9mcm9tX2lvKHZvaWQgKnByaXYsIHVuc2lnbmVkIGludCBhZGRyLAor
CQkJCXZvaWQgKmRzdCwgc2l6ZV90IGNvdW50KQoreworCXN0cnVjdCB3Znhfc3BpX3ByaXYgKmJ1
cyA9IHByaXY7CisJdTE2IHJlZ2FkZHIgPSAoYWRkciA8PCAxMikgfCAoY291bnQgLyAyKSB8IFNF
VF9SRUFEOworCXN0cnVjdCBzcGlfbWVzc2FnZSAgICAgIG07CisJc3RydWN0IHNwaV90cmFuc2Zl
ciAgICAgdF9hZGRyID0geworCQkudHhfYnVmICAgICAgICAgPSAmcmVnYWRkciwKKwkJLmxlbiAg
ICAgICAgICAgID0gc2l6ZW9mKHJlZ2FkZHIpLAorCX07CisJc3RydWN0IHNwaV90cmFuc2ZlciAg
ICAgdF9tc2cgPSB7CisJCS5yeF9idWYgICAgICAgICA9IGRzdCwKKwkJLmxlbiAgICAgICAgICAg
ID0gY291bnQsCisJfTsKKwl1MTYgKmRzdDE2ID0gZHN0OworCWludCByZXQsIGk7CisKKwlXQVJO
KGNvdW50ICUgMiwgImJ1ZmZlciBzaXplIG11c3QgYmUgYSBtdWx0aXBsZSBvZiAyIik7CisKKwlj
cHVfdG9fbGUxNnMoJnJlZ2FkZHIpOworCWlmIChidXMtPm5lZWRfc3dhYikKKwkJc3dhYjE2cygm
cmVnYWRkcik7CisKKwlzcGlfbWVzc2FnZV9pbml0KCZtKTsKKwlzcGlfbWVzc2FnZV9hZGRfdGFp
bCgmdF9hZGRyLCAmbSk7CisJc3BpX21lc3NhZ2VfYWRkX3RhaWwoJnRfbXNnLCAmbSk7CisJcmV0
ID0gc3BpX3N5bmMoYnVzLT5mdW5jLCAmbSk7CisKKwlpZiAoYnVzLT5uZWVkX3N3YWIgJiYgYWRk
ciA9PSBXRlhfUkVHX0NPTkZJRykKKwkJZm9yIChpID0gMDsgaSA8IGNvdW50IC8gMjsgaSsrKQor
CQkJc3dhYjE2cygmZHN0MTZbaV0pOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgd2Z4
X3NwaV9jb3B5X3RvX2lvKHZvaWQgKnByaXYsIHVuc2lnbmVkIGludCBhZGRyLAorCQkJICAgICAg
Y29uc3Qgdm9pZCAqc3JjLCBzaXplX3QgY291bnQpCit7CisJc3RydWN0IHdmeF9zcGlfcHJpdiAq
YnVzID0gcHJpdjsKKwl1MTYgcmVnYWRkciA9IChhZGRyIDw8IDEyKSB8IChjb3VudCAvIDIpOwor
CS8vIEZJWE1FOiB1c2UgYSBib3VuY2UgYnVmZmVyCisJdTE2ICpzcmMxNiA9ICh2b2lkICopc3Jj
OworCWludCByZXQsIGk7CisJc3RydWN0IHNwaV9tZXNzYWdlICAgICAgbTsKKwlzdHJ1Y3Qgc3Bp
X3RyYW5zZmVyICAgICB0X2FkZHIgPSB7CisJCS50eF9idWYgICAgICAgICA9ICZyZWdhZGRyLAor
CQkubGVuICAgICAgICAgICAgPSBzaXplb2YocmVnYWRkciksCisJfTsKKwlzdHJ1Y3Qgc3BpX3Ry
YW5zZmVyICAgICB0X21zZyA9IHsKKwkJLnR4X2J1ZiAgICAgICAgID0gc3JjLAorCQkubGVuICAg
ICAgICAgICAgPSBjb3VudCwKKwl9OworCisJV0FSTihjb3VudCAlIDIsICJidWZmZXIgc2l6ZSBt
dXN0IGJlIGEgbXVsdGlwbGUgb2YgMiIpOworCVdBUk4ocmVnYWRkciAmIFNFVF9SRUFELCAiYmFk
IGFkZHIgb3Igc2l6ZSBvdmVyZmxvdyIpOworCisJY3B1X3RvX2xlMTZzKCZyZWdhZGRyKTsKKwor
CS8vIFJlZ2lzdGVyIGFkZHJlc3MgYW5kIENPTkZJRyBjb250ZW50IGFsd2F5cyB1c2UgMTZiaXQg
YmlnIGVuZGlhbgorCS8vICgiQkFEQyIgb3JkZXIpCisJaWYgKGJ1cy0+bmVlZF9zd2FiKQorCQlz
d2FiMTZzKCZyZWdhZGRyKTsKKwlpZiAoYnVzLT5uZWVkX3N3YWIgJiYgYWRkciA9PSBXRlhfUkVH
X0NPTkZJRykKKwkJZm9yIChpID0gMDsgaSA8IGNvdW50IC8gMjsgaSsrKQorCQkJc3dhYjE2cygm
c3JjMTZbaV0pOworCisJc3BpX21lc3NhZ2VfaW5pdCgmbSk7CisJc3BpX21lc3NhZ2VfYWRkX3Rh
aWwoJnRfYWRkciwgJm0pOworCXNwaV9tZXNzYWdlX2FkZF90YWlsKCZ0X21zZywgJm0pOworCXJl
dCA9IHNwaV9zeW5jKGJ1cy0+ZnVuYywgJm0pOworCisJaWYgKGJ1cy0+bmVlZF9zd2FiICYmIGFk
ZHIgPT0gV0ZYX1JFR19DT05GSUcpCisJCWZvciAoaSA9IDA7IGkgPCBjb3VudCAvIDI7IGkrKykK
KwkJCXN3YWIxNnMoJnNyYzE2W2ldKTsKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgdm9pZCB3
Znhfc3BpX2xvY2sodm9pZCAqcHJpdikKK3sKK30KKworc3RhdGljIHZvaWQgd2Z4X3NwaV91bmxv
Y2sodm9pZCAqcHJpdikKK3sKK30KKworc3RhdGljIGlycXJldHVybl90IHdmeF9zcGlfaXJxX2hh
bmRsZXIoaW50IGlycSwgdm9pZCAqcHJpdikKK3sKKwlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXMg
PSBwcml2OworCisJd2Z4X2JoX3JlcXVlc3RfcngoYnVzLT5jb3JlKTsKKwlyZXR1cm4gSVJRX0hB
TkRMRUQ7Cit9CisKK3N0YXRpYyBpbnQgd2Z4X3NwaV9pcnFfc3Vic2NyaWJlKHZvaWQgKnByaXYp
Cit7CisJc3RydWN0IHdmeF9zcGlfcHJpdiAqYnVzID0gcHJpdjsKKwl1MzIgZmxhZ3M7CisKKwlm
bGFncyA9IGlycV9nZXRfdHJpZ2dlcl90eXBlKGJ1cy0+ZnVuYy0+aXJxKTsKKwlpZiAoIWZsYWdz
KQorCQlmbGFncyA9IElSUUZfVFJJR0dFUl9ISUdIOworCWZsYWdzIHw9IElSUUZfT05FU0hPVDsK
KwlyZXR1cm4gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycSgmYnVzLT5mdW5jLT5kZXYsIGJ1cy0+
ZnVuYy0+aXJxLCBOVUxMLAorCQkJCQkgd2Z4X3NwaV9pcnFfaGFuZGxlciwgSVJRRl9PTkVTSE9U
LAorCQkJCQkgIndmeCIsIGJ1cyk7Cit9CisKK3N0YXRpYyBpbnQgd2Z4X3NwaV9pcnFfdW5zdWJz
Y3JpYmUodm9pZCAqcHJpdikKK3sKKwlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXMgPSBwcml2Owor
CisJZGV2bV9mcmVlX2lycSgmYnVzLT5mdW5jLT5kZXYsIGJ1cy0+ZnVuYy0+aXJxLCBidXMpOwor
CXJldHVybiAwOworfQorCitzdGF0aWMgc2l6ZV90IHdmeF9zcGlfYWxpZ25fc2l6ZSh2b2lkICpw
cml2LCBzaXplX3Qgc2l6ZSkKK3sKKwkvLyBNb3N0IG9mIFNQSSBjb250cm9sbGVycyBhdm9pZCBE
TUEgaWYgYnVmZmVyIHNpemUgaXMgbm90IDMyYml0IGFsaWduZWQKKwlyZXR1cm4gQUxJR04oc2l6
ZSwgNCk7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaHdidXNfb3BzIHdmeF9zcGlfaHdidXNf
b3BzID0geworCS5jb3B5X2Zyb21faW8gPSB3Znhfc3BpX2NvcHlfZnJvbV9pbywKKwkuY29weV90
b19pbyA9IHdmeF9zcGlfY29weV90b19pbywKKwkuaXJxX3N1YnNjcmliZSA9IHdmeF9zcGlfaXJx
X3N1YnNjcmliZSwKKwkuaXJxX3Vuc3Vic2NyaWJlID0gd2Z4X3NwaV9pcnFfdW5zdWJzY3JpYmUs
CisJLmxvY2sJCQk9IHdmeF9zcGlfbG9jaywKKwkudW5sb2NrCQkJPSB3Znhfc3BpX3VubG9jaywK
KwkuYWxpZ25fc2l6ZQkJPSB3Znhfc3BpX2FsaWduX3NpemUsCit9OworCitzdGF0aWMgaW50IHdm
eF9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCit7CisJc3RydWN0IHdmeF9zcGlf
cHJpdiAqYnVzOworCWludCByZXQ7CisKKwlpZiAoIWZ1bmMtPmJpdHNfcGVyX3dvcmQpCisJCWZ1
bmMtPmJpdHNfcGVyX3dvcmQgPSAxNjsKKwlyZXQgPSBzcGlfc2V0dXAoZnVuYyk7CisJaWYgKHJl
dCkKKwkJcmV0dXJuIHJldDsKKwkvLyBUcmFjZSBiZWxvdyBpcyBhbHNvIGRpc3BsYXllZCBieSBz
cGlfc2V0dXAoKSBpZiBjb21waWxlZCB3aXRoIERFQlVHCisJZGV2X2RiZygmZnVuYy0+ZGV2LCAi
U1BJIHBhcmFtczogQ1M9JWQsIG1vZGU9JWQgYml0cy93b3JkPSVkIHNwZWVkPSVkXG4iLAorCQlm
dW5jLT5jaGlwX3NlbGVjdCwgZnVuYy0+bW9kZSwgZnVuYy0+Yml0c19wZXJfd29yZCwKKwkJZnVu
Yy0+bWF4X3NwZWVkX2h6KTsKKwlpZiAoZnVuYy0+Yml0c19wZXJfd29yZCAhPSAxNiAmJiBmdW5j
LT5iaXRzX3Blcl93b3JkICE9IDgpCisJCWRldl93YXJuKCZmdW5jLT5kZXYsICJ1bnVzdWFsIGJp
dHMvd29yZCB2YWx1ZTogJWRcbiIsCisJCQkgZnVuYy0+Yml0c19wZXJfd29yZCk7CisJaWYgKGZ1
bmMtPm1heF9zcGVlZF9oeiA+IDUwMDAwMDAwKQorCQlkZXZfd2FybigmZnVuYy0+ZGV2LCAiJWRI
eiBpcyBhIHZlcnkgaGlnaCBzcGVlZFxuIiwKKwkJCSBmdW5jLT5tYXhfc3BlZWRfaHopOworCisJ
YnVzID0gZGV2bV9remFsbG9jKCZmdW5jLT5kZXYsIHNpemVvZigqYnVzKSwgR0ZQX0tFUk5FTCk7
CisJaWYgKCFidXMpCisJCXJldHVybiAtRU5PTUVNOworCWJ1cy0+ZnVuYyA9IGZ1bmM7CisJaWYg
KGZ1bmMtPmJpdHNfcGVyX3dvcmQgPT0gOCB8fCBJU19FTkFCTEVEKENPTkZJR19DUFVfQklHX0VO
RElBTikpCisJCWJ1cy0+bmVlZF9zd2FiID0gdHJ1ZTsKKwlzcGlfc2V0X2RydmRhdGEoZnVuYywg
YnVzKTsKKworCWJ1cy0+Z3Bpb19yZXNldCA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCZmdW5j
LT5kZXYsICJyZXNldCIsCisJCQkJCQkgIEdQSU9EX09VVF9MT1cpOworCWlmIChJU19FUlIoYnVz
LT5ncGlvX3Jlc2V0KSkKKwkJcmV0dXJuIFBUUl9FUlIoYnVzLT5ncGlvX3Jlc2V0KTsKKwlpZiAo
IWJ1cy0+Z3Bpb19yZXNldCkgeworCQlkZXZfd2FybigmZnVuYy0+ZGV2LAorCQkJICJncGlvIHJl
c2V0IGlzIG5vdCBkZWZpbmVkLCB0cnlpbmcgdG8gbG9hZCBmaXJtd2FyZSBhbnl3YXlcbiIpOwor
CX0gZWxzZSB7CisJCWdwaW9kX3NldF9jb25zdW1lcl9uYW1lKGJ1cy0+Z3Bpb19yZXNldCwgIndm
eCByZXNldCIpOworCQlpZiAoc3BpX2dldF9kZXZpY2VfaWQoZnVuYyktPmRyaXZlcl9kYXRhICYg
V0ZYX1JFU0VUX0lOVkVSVEVEKQorCQkJZ3Bpb2RfdG9nZ2xlX2FjdGl2ZV9sb3coYnVzLT5ncGlv
X3Jlc2V0KTsKKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGJ1cy0+Z3Bpb19yZXNldCwgMSk7
CisJCXVzbGVlcF9yYW5nZSgxMDAsIDE1MCk7CisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChi
dXMtPmdwaW9fcmVzZXQsIDApOworCQl1c2xlZXBfcmFuZ2UoMjAwMCwgMjUwMCk7CisJfQorCisJ
YnVzLT5jb3JlID0gd2Z4X2luaXRfY29tbW9uKCZmdW5jLT5kZXYsICZ3Znhfc3BpX3BkYXRhLAor
CQkJCSAgICAmd2Z4X3NwaV9od2J1c19vcHMsIGJ1cyk7CisJaWYgKCFidXMtPmNvcmUpCisJCXJl
dHVybiAtRUlPOworCisJcmV0dXJuIHdmeF9wcm9iZShidXMtPmNvcmUpOworfQorCitzdGF0aWMg
aW50IHdmeF9zcGlfcmVtb3ZlKHN0cnVjdCBzcGlfZGV2aWNlICpmdW5jKQoreworCXN0cnVjdCB3
Znhfc3BpX3ByaXYgKmJ1cyA9IHNwaV9nZXRfZHJ2ZGF0YShmdW5jKTsKKworCXdmeF9yZWxlYXNl
KGJ1cy0+Y29yZSk7CisJcmV0dXJuIDA7Cit9CisKKy8qCisgKiBGb3IgZHluYW1pYyBkcml2ZXIg
YmluZGluZywga2VybmVsIGRvZXMgbm90IHVzZSBPRiB0byBtYXRjaCBkcml2ZXIuIEl0IG9ubHkK
KyAqIHVzZSBtb2RhbGlhcyBhbmQgbW9kYWxpYXMgaXMgYSBjb3B5IG9mICdjb21wYXRpYmxlJyBE
VCBub2RlIHdpdGggdmVuZG9yCisgKiBzdHJpcHBlZC4KKyAqLworc3RhdGljIGNvbnN0IHN0cnVj
dCBzcGlfZGV2aWNlX2lkIHdmeF9zcGlfaWRbXSA9IHsKKwl7ICJ3Zngtc3BpIiwgV0ZYX1JFU0VU
X0lOVkVSVEVEIH0sCisJeyAid2YyMDAiLCAwIH0sCisJeyB9LAorfTsKK01PRFVMRV9ERVZJQ0Vf
VEFCTEUoc3BpLCB3Znhfc3BpX2lkKTsKKworI2lmZGVmIENPTkZJR19PRgorc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NwaV9vZl9tYXRjaFtdID0geworCXsgLmNvbXBhdGli
bGUgPSAic2lsYWJzLHdmeC1zcGkiLCAuZGF0YSA9ICh2b2lkICopV0ZYX1JFU0VUX0lOVkVSVEVE
IH0sCisJeyAuY29tcGF0aWJsZSA9ICJzaWxhYnMsd2YyMDAiIH0sCisJeyB9LAorfTsKK01PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIHdmeF9zcGlfb2ZfbWF0Y2gpOworI2VuZGlmCisKK3N0cnVjdCBz
cGlfZHJpdmVyIHdmeF9zcGlfZHJpdmVyID0geworCS5kcml2ZXIgPSB7CisJCS5uYW1lID0gIndm
eC1zcGkiLAorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIod2Z4X3NwaV9vZl9tYXRj
aCksCisJfSwKKwkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAorCS5wcm9iZSA9IHdmeF9zcGlfcHJv
YmUsCisJLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAorfTsKLS0gCjIuMjguMAoK
