Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5807293CB0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407231AbgJTNBd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 09:01:33 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:55456
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406283AbgJTM7X (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 08:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln5kewugr/2+SYSWoe90njK4zs7Xaq9L/XZU322CPu6JZewzHsAQEyklcNyidkA12psTWsx5J0dErk1/zImEVfPJ6JG6O29VghdqHjLDGc9XnwZDpvG7ezUTKS6YmabU4HdYtMqJLOuru7XSdimhAanK8eO4snGzuoA4Ofln3YxOkdL2LlBHrivgjulyZNorstKpmi3MvxEQ2mbnOi5WfuCxW7acY/giuazU1pncFtMxKKGGHI/WJzy0LdfqqEgCAyjhTaPSAk9SjWfCtWlrtcreMY3CuC660W+Ts7e+Xw3GAMLzWJLYK3+0X8Zkk4QQHPuWU/qcsAlIhdvojpE7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5+PN3iLL6PBnsGuFQkW6jUkJlNQbyd9H8kZdsdinho=;
 b=KLLhCK2THPyWM9vbDv646W8UzLxwUAEUYT5nFQzJU46ZDPuh09hBjS2qaQBFca/FCZHYKY8CleWnXLIlYxZDRM9rQ5/ODGOxHC+1Fdob0X4i8mvCX8ZyvyfJGUWefstV21Ysd4Mn9OKkZ+JJfdVcTM1t5GaDCcRV8UgKUeaO1b62yV4465OlcOZqU721TymHEql7mkvE5MKE/u24gsPhGsWUFPDlT+iZpX52MON2kmzpA3u6fIzaJniexy3fcKLc8h/nUSfz7n/xgcIFNcT+Dn+iUvc/BUBArWvLuiRShWdUYL6XoDGgdBvfQ13AEXI2WdwcSqs6peXTqzInYYXypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5+PN3iLL6PBnsGuFQkW6jUkJlNQbyd9H8kZdsdinho=;
 b=Ovj1HuCQ1c9VIZUKgNUuU/kGWXpHJ/el/dcrGNzOlj7e/W0H9YRpdXF64PX6aUZeURel4ZIrQ3d/M/4EuPXUuTJ7dfJRsYLw1TivEGece4ZCAZ174xfCAt/we2cM2+HGX2TTUcYltfrgUejVCMIaSs9zj/Bp/7El4FMpOj5Uadk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3040.namprd11.prod.outlook.com (2603:10b6:805:db::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 12:59:17 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 12:59:17 +0000
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
Subject: [PATCH v2 15/24] wfx: add hif_rx.c/hif_rx.h
Date:   Tue, 20 Oct 2020 14:58:08 +0200
Message-Id: <20201020125817.1632995-16-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020125817.1632995-1-Jerome.Pouiller@silabs.com>
References: <20201020125817.1632995-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [37.71.187.125]
X-ClientProxiedBy: PR3P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::31) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (37.71.187.125) by PR3P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 12:59:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1561e34a-47ac-4814-eccb-08d874f7f3a9
X-MS-TrafficTypeDiagnostic: SN6PR11MB3040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB3040AD7535D3C5EFFC5D8D49931F0@SN6PR11MB3040.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+3+JpimN+kPXKb9ni9AtiUmkE+k5dz3pslyteTrDXglfEiLKRvm29a3AKegLlNfmDFDBf4yGb1giUpOXriivMdPG2iEjhbnd6D6hJEp3/ijwbxpvb6Jf+v3Brl9Bpq2vI9+NFLaVsYgvlmXaee0NXR5zzoYsvZNTaAbAAK8IAO0x04fkNriAtlebpdyjLSmWQ8V25RiIg8sZcAfgCqmZXjQhWGApC6jg2ByFmYHptdHefStHPr0t/NPGH1PqGL5w7tuXPxFNAJpAh9dWxzB7xI+2v64Z6NOsHDJSOYJMWyUjTFX0v6KpTdUPGj00ZWAipTkR3NW/axWEAT3swk6hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39840400004)(4326008)(5660300002)(54906003)(478600001)(30864003)(83380400001)(86362001)(316002)(1076003)(2906002)(186003)(6486002)(66574015)(16526019)(7696005)(66556008)(7416002)(36756003)(26005)(8676002)(66476007)(52116002)(66946007)(107886003)(956004)(2616005)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9cZlJGhQi32Cbk6+5779hEtPCBYswBbkQUFT0JwXWrTCN89WUZrdXW4M3zPr0j3kN/VEC/WGmSxCrqGCUCj2hNO0jMaFPj73lBDUXG35UfgUNlWn62iWThMx3yhKVb+PKUVhCBEeKFGWQ4GXRMBAnDq17RmSoxqx8zMT8j52SJ1m9I7fEOeH2tGuxGln1/9loG2wI87406Ovn0a+yYRDTgXpfMciUuwUVGjtQyuRAQJiCyZl8xwyEdko4zUPxsIRFddTicE4438NV41736iD33elbwPC8eutprPENFcwx88lvNQlSmk/nH/EQ6Eys1q9MLyXgz/3PbZB/xqUlTh8af7jmYSaT1uhtPcCuO2z4QIRckDoJk8hpMnlizY/N+QOJ49QeUyngNTKFivm/jU7gtnmsUeyFXDEeIYYUnChDwBmbobC827KpK36de3aaaLOI5ffDXlmT992v4jmrLrtwGC0VOhCdWnRxabauVc5SEzZpgUIj4b7EA1mH0yuhyeVs9ofgVgwBFKm4C9rs/queLlGCYhn5k34Yd1keljXO31j7o2a+K8WOLKNeVfl0eTo+7XQgudIftFWBbgDiLzPUB2isBtS7vvlJo399Q/F5wyfthvnGg+fEszwqXnM1aHeJr097jhtE6j4q5r8OgqY0Q==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1561e34a-47ac-4814-eccb-08d874f7f3a9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 12:59:16.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1gCm7rb/0EtoaYea2qOByQ0Pl7K39OW3zwdMRhYuauDP6scDnoE3yFEVS1d/O4mSbav3yszWV3sQTwXXZOO0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3040
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3J4LmMgfCA0MTUgKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlm
X3J4LmggfCAgMTggKwogMiBmaWxlcyBjaGFuZ2VkLCA0MzMgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3J4LmMKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl9yeC5o
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfcnguYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3J4LmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi41NmE1Zjg5MTQ0N2IKLS0tIC9kZXYvbnVsbAorKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl9yeC5jCkBAIC0wLDAgKzEsNDE1
IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisvKgorICogSW1w
bGVtZW50YXRpb24gb2YgY2hpcC10by1ob3N0IGV2ZW50IChha2EgaW5kaWNhdGlvbnMpIG9mIFdG
eHh4IFNwbGl0IE1hYworICogKFdTTSkgQVBJLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0y
MDIwLCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5jLgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBT
VC1Fcmljc3NvbgorICovCisjaW5jbHVkZSA8bGludXgvc2tidWZmLmg+CisjaW5jbHVkZSA8bGlu
dXgvZXRoZXJkZXZpY2UuaD4KKworI2luY2x1ZGUgImhpZl9yeC5oIgorI2luY2x1ZGUgIndmeC5o
IgorI2luY2x1ZGUgInNjYW4uaCIKKyNpbmNsdWRlICJiaC5oIgorI2luY2x1ZGUgInN0YS5oIgor
I2luY2x1ZGUgImRhdGFfcnguaCIKKyNpbmNsdWRlICJoaWZfYXBpX2NtZC5oIgorCitzdGF0aWMg
aW50IGhpZl9nZW5lcmljX2NvbmZpcm0oc3RydWN0IHdmeF9kZXYgKndkZXYsCisJCQkgICAgICAg
Y29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgY29uc3Qgdm9pZCAqYnVmKQoreworCS8vIEFsbCBj
b25maXJtIG1lc3NhZ2VzIHN0YXJ0IHdpdGggc3RhdHVzCisJaW50IHN0YXR1cyA9IGxlMzJfdG9f
Y3B1cCgoX19sZTMyICopYnVmKTsKKwlpbnQgY21kID0gaGlmLT5pZDsKKwlpbnQgbGVuID0gbGUx
Nl90b19jcHUoaGlmLT5sZW4pIC0gNDsgLy8gZHJvcCBoZWFkZXIKKworCVdBUk4oIW11dGV4X2lz
X2xvY2tlZCgmd2Rldi0+aGlmX2NtZC5sb2NrKSwgImRhdGEgbG9ja2luZyBlcnJvciIpOworCisJ
aWYgKCF3ZGV2LT5oaWZfY21kLmJ1Zl9zZW5kKSB7CisJCWRldl93YXJuKHdkZXYtPmRldiwgInVu
ZXhwZWN0ZWQgY29uZmlybWF0aW9uOiAweCUuMnhcbiIsIGNtZCk7CisJCXJldHVybiAtRUlOVkFM
OworCX0KKworCWlmIChjbWQgIT0gd2Rldi0+aGlmX2NtZC5idWZfc2VuZC0+aWQpIHsKKwkJZGV2
X3dhcm4od2Rldi0+ZGV2LAorCQkJICJjaGlwIHJlc3BvbnNlIG1pc21hdGNoIHJlcXVlc3Q6IDB4
JS4yeCB2cyAweCUuMnhcbiIsCisJCQkgY21kLCB3ZGV2LT5oaWZfY21kLmJ1Zl9zZW5kLT5pZCk7
CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCWlmICh3ZGV2LT5oaWZfY21kLmJ1Zl9yZWN2KSB7
CisJCWlmICh3ZGV2LT5oaWZfY21kLmxlbl9yZWN2ID49IGxlbiAmJiBsZW4gPiAwKQorCQkJbWVt
Y3B5KHdkZXYtPmhpZl9jbWQuYnVmX3JlY3YsIGJ1ZiwgbGVuKTsKKwkJZWxzZQorCQkJc3RhdHVz
ID0gLUVJTzsKKwl9CisJd2Rldi0+aGlmX2NtZC5yZXQgPSBzdGF0dXM7CisKKwljb21wbGV0ZSgm
d2Rldi0+aGlmX2NtZC5kb25lKTsKKwlyZXR1cm4gc3RhdHVzOworfQorCitzdGF0aWMgaW50IGhp
Zl90eF9jb25maXJtKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LAorCQkJICBjb25zdCBzdHJ1Y3QgaGlm
X21zZyAqaGlmLCBjb25zdCB2b2lkICpidWYpCit7CisJY29uc3Qgc3RydWN0IGhpZl9jbmZfdHgg
KmJvZHkgPSBidWY7CisKKwl3ZnhfdHhfY29uZmlybV9jYih3ZGV2LCBib2R5KTsKKwlyZXR1cm4g
MDsKK30KKworc3RhdGljIGludCBoaWZfbXVsdGlfdHhfY29uZmlybShzdHJ1Y3Qgd2Z4X2RldiAq
d2RldiwKKwkJCQljb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLCBjb25zdCB2b2lkICpidWYpCit7
CisJY29uc3Qgc3RydWN0IGhpZl9jbmZfbXVsdGlfdHJhbnNtaXQgKmJvZHkgPSBidWY7CisJaW50
IGk7CisKKwlXQVJOKGJvZHktPm51bV90eF9jb25mcyA8PSAwLCAiY29ycnVwdGVkIG1lc3NhZ2Ui
KTsKKwlmb3IgKGkgPSAwOyBpIDwgYm9keS0+bnVtX3R4X2NvbmZzOyBpKyspCisJCXdmeF90eF9j
b25maXJtX2NiKHdkZXYsICZib2R5LT50eF9jb25mX3BheWxvYWRbaV0pOworCXJldHVybiAwOwor
fQorCitzdGF0aWMgaW50IGhpZl9zdGFydHVwX2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndk
ZXYsCisJCQkJICBjb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLCBjb25zdCB2b2lkICpidWYpCit7
CisJY29uc3Qgc3RydWN0IGhpZl9pbmRfc3RhcnR1cCAqYm9keSA9IGJ1ZjsKKworCWlmIChib2R5
LT5zdGF0dXMgfHwgYm9keS0+ZmlybXdhcmVfdHlwZSA+IDQpIHsKKwkJZGV2X2Vycih3ZGV2LT5k
ZXYsICJyZWNlaXZlZCBpbnZhbGlkIHN0YXJ0dXAgaW5kaWNhdGlvbiIpOworCQlyZXR1cm4gLUVJ
TlZBTDsKKwl9CisJbWVtY3B5KCZ3ZGV2LT5od19jYXBzLCBib2R5LCBzaXplb2Yoc3RydWN0IGhp
Zl9pbmRfc3RhcnR1cCkpOworCWxlMTZfdG9fY3B1cygoX19sZTE2ICopJndkZXYtPmh3X2NhcHMu
aGFyZHdhcmVfaWQpOworCWxlMTZfdG9fY3B1cygoX19sZTE2ICopJndkZXYtPmh3X2NhcHMubnVt
X2lucF9jaF9idWZzKTsKKwlsZTE2X3RvX2NwdXMoKF9fbGUxNiAqKSZ3ZGV2LT5od19jYXBzLnNp
emVfaW5wX2NoX2J1Zik7CisJbGUzMl90b19jcHVzKChfX2xlMzIgKikmd2Rldi0+aHdfY2Fwcy5z
dXBwb3J0ZWRfcmF0ZV9tYXNrKTsKKworCWNvbXBsZXRlKCZ3ZGV2LT5maXJtd2FyZV9yZWFkeSk7
CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgaGlmX3dha2V1cF9pbmRpY2F0aW9uKHN0cnVj
dCB3ZnhfZGV2ICp3ZGV2LAorCQkJCSBjb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLCBjb25zdCB2
b2lkICpidWYpCit7CisJaWYgKCF3ZGV2LT5wZGF0YS5ncGlvX3dha2V1cCB8fAorCSAgICBncGlv
ZF9nZXRfdmFsdWUod2Rldi0+cGRhdGEuZ3Bpb193YWtldXApID09IDApIHsKKwkJZGV2X3dhcm4o
d2Rldi0+ZGV2LCAidW5leHBlY3RlZCB3YWtlLXVwIGluZGljYXRpb25cbiIpOworCQlyZXR1cm4g
LUVJTzsKKwl9CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgaGlmX3JlY2VpdmVfaW5kaWNh
dGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwKKwkJCQkgIGNvbnN0IHN0cnVjdCBoaWZfbXNnICpo
aWYsCisJCQkJICBjb25zdCB2b2lkICpidWYsIHN0cnVjdCBza19idWZmICpza2IpCit7CisJc3Ry
dWN0IHdmeF92aWYgKnd2aWYgPSB3ZGV2X3RvX3d2aWYod2RldiwgaGlmLT5pbnRlcmZhY2UpOwor
CWNvbnN0IHN0cnVjdCBoaWZfaW5kX3J4ICpib2R5ID0gYnVmOworCisJaWYgKCF3dmlmKSB7CisJ
CWRldl93YXJuKHdkZXYtPmRldiwgIiVzOiBpZ25vcmUgcnggZGF0YSBmb3Igbm9uLWV4aXN0ZW50
IHZpZiAlZFxuIiwKKwkJCSBfX2Z1bmNfXywgaGlmLT5pbnRlcmZhY2UpOworCQlyZXR1cm4gLUVJ
TzsKKwl9CisJc2tiX3B1bGwoc2tiLCBzaXplb2Yoc3RydWN0IGhpZl9tc2cpICsgc2l6ZW9mKHN0
cnVjdCBoaWZfaW5kX3J4KSk7CisJd2Z4X3J4X2NiKHd2aWYsIGJvZHksIHNrYik7CisKKwlyZXR1
cm4gMDsKK30KKworc3RhdGljIGludCBoaWZfZXZlbnRfaW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2Rl
diAqd2RldiwKKwkJCQljb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLCBjb25zdCB2b2lkICpidWYp
Cit7CisJc3RydWN0IHdmeF92aWYgKnd2aWYgPSB3ZGV2X3RvX3d2aWYod2RldiwgaGlmLT5pbnRl
cmZhY2UpOworCWNvbnN0IHN0cnVjdCBoaWZfaW5kX2V2ZW50ICpib2R5ID0gYnVmOworCWludCB0
eXBlID0gbGUzMl90b19jcHUoYm9keS0+ZXZlbnRfaWQpOworCisJaWYgKCF3dmlmKSB7CisJCWRl
dl93YXJuKHdkZXYtPmRldiwgIiVzOiByZWNlaXZlZCBldmVudCBmb3Igbm9uLWV4aXN0ZW50IHZp
ZlxuIiwgX19mdW5jX18pOworCQlyZXR1cm4gLUVJTzsKKwl9CisKKwlzd2l0Y2ggKHR5cGUpIHsK
KwljYXNlIEhJRl9FVkVOVF9JTkRfUkNQSV9SU1NJOgorCQl3ZnhfZXZlbnRfcmVwb3J0X3Jzc2ko
d3ZpZiwgYm9keS0+ZXZlbnRfZGF0YS5yY3BpX3Jzc2kpOworCQlicmVhazsKKwljYXNlIEhJRl9F
VkVOVF9JTkRfQlNTTE9TVDoKKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ3dmlmLT5iZWFjb25f
bG9zc193b3JrLCAwKTsKKwkJYnJlYWs7CisJY2FzZSBISUZfRVZFTlRfSU5EX0JTU1JFR0FJTkVE
OgorCQljYW5jZWxfZGVsYXllZF93b3JrKCZ3dmlmLT5iZWFjb25fbG9zc193b3JrKTsKKwkJZGV2
X2RiZyh3ZGV2LT5kZXYsICJpZ25vcmUgQlNTUkVHQUlORUQgaW5kaWNhdGlvblxuIik7CisJCWJy
ZWFrOworCWNhc2UgSElGX0VWRU5UX0lORF9QU19NT0RFX0VSUk9SOgorCQlkZXZfd2Fybih3ZGV2
LT5kZXYsICJlcnJvciB3aGlsZSBwcm9jZXNzaW5nIHBvd2VyIHNhdmUgcmVxdWVzdDogJWRcbiIs
CisJCQkgbGUzMl90b19jcHUoYm9keS0+ZXZlbnRfZGF0YS5wc19tb2RlX2Vycm9yKSk7CisJCWJy
ZWFrOworCWRlZmF1bHQ6CisJCWRldl93YXJuKHdkZXYtPmRldiwgInVuaGFuZGxlZCBldmVudCBp
bmRpY2F0aW9uOiAlLjJ4XG4iLAorCQkJIHR5cGUpOworCQlicmVhazsKKwl9CisJcmV0dXJuIDA7
Cit9CisKK3N0YXRpYyBpbnQgaGlmX3BtX21vZGVfY29tcGxldGVfaW5kaWNhdGlvbihzdHJ1Y3Qg
d2Z4X2RldiAqd2RldiwKKwkJCQkJICAgY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwKKwkJCQkJ
ICAgY29uc3Qgdm9pZCAqYnVmKQoreworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gd2Rldl90b193
dmlmKHdkZXYsIGhpZi0+aW50ZXJmYWNlKTsKKworCWlmICghd3ZpZikgeworCQlkZXZfd2Fybih3
ZGV2LT5kZXYsICIlczogcmVjZWl2ZWQgZXZlbnQgZm9yIG5vbi1leGlzdGVudCB2aWZcbiIsIF9f
ZnVuY19fKTsKKwkJcmV0dXJuIC1FSU87CisJfQorCWNvbXBsZXRlKCZ3dmlmLT5zZXRfcG1fbW9k
ZV9jb21wbGV0ZSk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBoaWZfc2Nhbl9jb21w
bGV0ZV9pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LAorCQkJCQljb25zdCBzdHJ1Y3Qg
aGlmX21zZyAqaGlmLAorCQkJCQljb25zdCB2b2lkICpidWYpCit7CisJc3RydWN0IHdmeF92aWYg
Knd2aWYgPSB3ZGV2X3RvX3d2aWYod2RldiwgaGlmLT5pbnRlcmZhY2UpOworCisJaWYgKCF3dmlm
KSB7CisJCWRldl93YXJuKHdkZXYtPmRldiwgIiVzOiByZWNlaXZlZCBldmVudCBmb3Igbm9uLWV4
aXN0ZW50IHZpZlxuIiwgX19mdW5jX18pOworCQlyZXR1cm4gLUVJTzsKKwl9CisKKwl3Znhfc2Nh
bl9jb21wbGV0ZSh3dmlmKTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IGhpZl9qb2lu
X2NvbXBsZXRlX2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsCisJCQkJCWNvbnN0IHN0
cnVjdCBoaWZfbXNnICpoaWYsCisJCQkJCWNvbnN0IHZvaWQgKmJ1ZikKK3sKKwlzdHJ1Y3Qgd2Z4
X3ZpZiAqd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCBoaWYtPmludGVyZmFjZSk7CisKKwlpZiAo
IXd2aWYpIHsKKwkJZGV2X3dhcm4od2Rldi0+ZGV2LCAiJXM6IHJlY2VpdmVkIGV2ZW50IGZvciBu
b24tZXhpc3RlbnQgdmlmXG4iLCBfX2Z1bmNfXyk7CisJCXJldHVybiAtRUlPOworCX0KKwlkZXZf
d2Fybih3ZGV2LT5kZXYsICJ1bmF0dGVuZGVkIEpvaW5Db21wbGV0ZUluZFxuIik7CisKKwlyZXR1
cm4gMDsKK30KKworc3RhdGljIGludCBoaWZfc3VzcGVuZF9yZXN1bWVfaW5kaWNhdGlvbihzdHJ1
Y3Qgd2Z4X2RldiAqd2RldiwKKwkJCQkJIGNvbnN0IHN0cnVjdCBoaWZfbXNnICpoaWYsCisJCQkJ
CSBjb25zdCB2b2lkICpidWYpCit7CisJY29uc3Qgc3RydWN0IGhpZl9pbmRfc3VzcGVuZF9yZXN1
bWVfdHggKmJvZHkgPSBidWY7CisJc3RydWN0IHdmeF92aWYgKnd2aWY7CisKKwlpZiAoYm9keS0+
YmNfbWNfb25seSkgeworCQl3dmlmID0gd2Rldl90b193dmlmKHdkZXYsIGhpZi0+aW50ZXJmYWNl
KTsKKwkJaWYgKCF3dmlmKSB7CisJCQlkZXZfd2Fybih3ZGV2LT5kZXYsICIlczogcmVjZWl2ZWQg
ZXZlbnQgZm9yIG5vbi1leGlzdGVudCB2aWZcbiIsIF9fZnVuY19fKTsKKwkJCXJldHVybiAtRUlP
OworCQl9CisJCWlmIChib2R5LT5yZXN1bWUpCisJCQl3Znhfc3VzcGVuZF9yZXN1bWVfbWMod3Zp
ZiwgU1RBX05PVElGWV9BV0FLRSk7CisJCWVsc2UKKwkJCXdmeF9zdXNwZW5kX3Jlc3VtZV9tYyh3
dmlmLCBTVEFfTk9USUZZX1NMRUVQKTsKKwl9IGVsc2UgeworCQlXQVJOKGJvZHktPnBlZXJfc3Rh
X3NldCwgIm1pc3VuZGVyc3Rvb2QgaW5kaWNhdGlvbiIpOworCQlXQVJOKGhpZi0+aW50ZXJmYWNl
ICE9IDIsICJtaXN1bmRlcnN0b29kIGluZGljYXRpb24iKTsKKwkJaWYgKGJvZHktPnJlc3VtZSkK
KwkJCXdmeF9zdXNwZW5kX2hvdF9kZXYod2RldiwgU1RBX05PVElGWV9BV0FLRSk7CisJCWVsc2UK
KwkJCXdmeF9zdXNwZW5kX2hvdF9kZXYod2RldiwgU1RBX05PVElGWV9TTEVFUCk7CisJfQorCisJ
cmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgaGlmX2dlbmVyaWNfaW5kaWNhdGlvbihzdHJ1Y3Qg
d2Z4X2RldiAqd2RldiwKKwkJCQkgIGNvbnN0IHN0cnVjdCBoaWZfbXNnICpoaWYsIGNvbnN0IHZv
aWQgKmJ1ZikKK3sKKwljb25zdCBzdHJ1Y3QgaGlmX2luZF9nZW5lcmljICpib2R5ID0gYnVmOwor
CWludCB0eXBlID0gbGUzMl90b19jcHUoYm9keS0+dHlwZSk7CisKKwlzd2l0Y2ggKHR5cGUpIHsK
KwljYXNlIEhJRl9HRU5FUklDX0lORElDQVRJT05fVFlQRV9SQVc6CisJCXJldHVybiAwOworCWNh
c2UgSElGX0dFTkVSSUNfSU5ESUNBVElPTl9UWVBFX1NUUklORzoKKwkJZGV2X2luZm8od2Rldi0+
ZGV2LCAiZmlybXdhcmUgc2F5czogJXNcbiIsIChjaGFyICopJmJvZHktPmRhdGEpOworCQlyZXR1
cm4gMDsKKwljYXNlIEhJRl9HRU5FUklDX0lORElDQVRJT05fVFlQRV9SWF9TVEFUUzoKKwkJbXV0
ZXhfbG9jaygmd2Rldi0+cnhfc3RhdHNfbG9jayk7CisJCS8vIE9sZGVyIGZpcm13YXJlIHNlbmQg
YSBnZW5lcmljIGluZGljYXRpb24gYmVzaWRlIFJ4U3RhdHMKKwkJaWYgKCF3ZnhfYXBpX29sZGVy
X3RoYW4od2RldiwgMSwgNCkpCisJCQlkZXZfaW5mbyh3ZGV2LT5kZXYsICJSeCB0ZXN0IG9uZ29p
bmcuIFRlbXBlcmF0dXJlOiAlZCBkZWdyZWVzIENcbiIsCisJCQkJIGJvZHktPmRhdGEucnhfc3Rh
dHMuY3VycmVudF90ZW1wKTsKKwkJbWVtY3B5KCZ3ZGV2LT5yeF9zdGF0cywgJmJvZHktPmRhdGEu
cnhfc3RhdHMsCisJCSAgICAgICBzaXplb2Yod2Rldi0+cnhfc3RhdHMpKTsKKwkJbXV0ZXhfdW5s
b2NrKCZ3ZGV2LT5yeF9zdGF0c19sb2NrKTsKKwkJcmV0dXJuIDA7CisJY2FzZSBISUZfR0VORVJJ
Q19JTkRJQ0FUSU9OX1RZUEVfVFhfUE9XRVJfTE9PUF9JTkZPOgorCQltdXRleF9sb2NrKCZ3ZGV2
LT50eF9wb3dlcl9sb29wX2luZm9fbG9jayk7CisJCW1lbWNweSgmd2Rldi0+dHhfcG93ZXJfbG9v
cF9pbmZvLAorCQkgICAgICAgJmJvZHktPmRhdGEudHhfcG93ZXJfbG9vcF9pbmZvLAorCQkgICAg
ICAgc2l6ZW9mKHdkZXYtPnR4X3Bvd2VyX2xvb3BfaW5mbykpOworCQltdXRleF91bmxvY2soJndk
ZXYtPnR4X3Bvd2VyX2xvb3BfaW5mb19sb2NrKTsKKwkJcmV0dXJuIDA7CisJZGVmYXVsdDoKKwkJ
ZGV2X2Vycih3ZGV2LT5kZXYsICJnZW5lcmljX2luZGljYXRpb246IHVua25vd24gaW5kaWNhdGlv
biB0eXBlOiAlIy44eFxuIiwKKwkJCXR5cGUpOworCQlyZXR1cm4gLUVJTzsKKwl9Cit9CisKK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgeworCWludCB2YWw7CisJY29uc3QgY2hhciAqc3RyOworCWJvb2wg
aGFzX3BhcmFtOworfSBoaWZfZXJyb3JzW10gPSB7CisJeyBISUZfRVJST1JfRklSTVdBUkVfUk9M
TEJBQ0ssCisJCSJyb2xsYmFjayBzdGF0dXMiIH0sCisJeyBISUZfRVJST1JfRklSTVdBUkVfREVC
VUdfRU5BQkxFRCwKKwkJImRlYnVnIGZlYXR1cmUgZW5hYmxlZCIgfSwKKwl7IEhJRl9FUlJPUl9Q
RFNfUEFZTE9BRCwKKwkJIlBEUyB2ZXJzaW9uIGlzIG5vdCBzdXBwb3J0ZWQiIH0sCisJeyBISUZf
RVJST1JfUERTX1RFU1RGRUFUVVJFLAorCQkiUERTIGFzayBmb3IgYW4gdW5rbm93biB0ZXN0IG1v
ZGUiIH0sCisJeyBISUZfRVJST1JfT09SX1ZPTFRBR0UsCisJCSJvdXQtb2YtcmFuZ2UgcG93ZXIg
c3VwcGx5IHZvbHRhZ2UiLCB0cnVlIH0sCisJeyBISUZfRVJST1JfT09SX1RFTVBFUkFUVVJFLAor
CQkib3V0LW9mLXJhbmdlIHRlbXBlcmF0dXJlIiwgdHJ1ZSB9LAorCXsgSElGX0VSUk9SX1NMS19S
RVFfRFVSSU5HX0tFWV9FWENIQU5HRSwKKwkJInNlY3VyZSBsaW5rIGRvZXMgbm90IGV4cGVjdCBy
ZXF1ZXN0IGR1cmluZyBrZXkgZXhjaGFuZ2UiIH0sCisJeyBISUZfRVJST1JfU0xLX1NFU1NJT05f
S0VZLAorCQkic2VjdXJlIGxpbmsgc2Vzc2lvbiBrZXkgaXMgaW52YWxpZCIgfSwKKwl7IEhJRl9F
UlJPUl9TTEtfT1ZFUkZMT1csCisJCSJzZWN1cmUgbGluayBvdmVyZmxvdyIgfSwKKwl7IEhJRl9F
UlJPUl9TTEtfV1JPTkdfRU5DUllQVElPTl9TVEFURSwKKwkJInNlY3VyZSBsaW5rIG1lc3NhZ2Vz
IGxpc3QgZG9lcyBub3QgbWF0Y2ggbWVzc2FnZSBlbmNyeXB0aW9uIiB9LAorCXsgSElGX0VSUk9S
X1NMS19VTkNPTkZJR1VSRUQsCisJCSJzZWN1cmUgbGluayBub3QgeWV0IGNvbmZpZ3VyZWQiIH0s
CisJeyBISUZfRVJST1JfSElGX0JVU19GUkVRVUVOQ1lfVE9PX0xPVywKKwkJImJ1cyBjbG9jayBp
cyB0b28gc2xvdyAoPDFrSHopIiB9LAorCXsgSElGX0VSUk9SX0hJRl9SWF9EQVRBX1RPT19MQVJH
RSwKKwkJIkhJRiBtZXNzYWdlIHRvbyBsYXJnZSIgfSwKKwkvLyBGb2xsb3dpbmcgZXJyb3JzIG9u
bHkgZXhpc3RzIGluIG9sZCBmaXJtd2FyZSB2ZXJzaW9uczoKKwl7IEhJRl9FUlJPUl9ISUZfVFhf
UVVFVUVfRlVMTCwKKwkJIkhJRiBtZXNzYWdlcyBxdWV1ZSBpcyBmdWxsIiB9LAorCXsgSElGX0VS
Uk9SX0hJRl9CVVMsCisJCSJISUYgYnVzIiB9LAorCXsgSElGX0VSUk9SX1NMS19NVUxUSV9UWF9V
TlNVUFBPUlRFRCwKKwkJInNlY3VyZSBsaW5rIGRvZXMgbm90IHN1cHBvcnQgbXVsdGktdHggY29u
ZmlybWF0aW9ucyIgfSwKKwl7IEhJRl9FUlJPUl9TTEtfT1VUREFURURfU0VTU0lPTl9LRVksCisJ
CSJzZWN1cmUgbGluayBzZXNzaW9uIGtleSBpcyBvdXRkYXRlZCIgfSwKKwl7IEhJRl9FUlJPUl9T
TEtfREVDUllQVElPTiwKKwkJInNlY3VyZSBsaW5rIHBhcmFtcyAobm9uY2Ugb3IgdGFnKSBtaXNt
YXRjaCIgfSwKK307CisKK3N0YXRpYyBpbnQgaGlmX2Vycm9yX2luZGljYXRpb24oc3RydWN0IHdm
eF9kZXYgKndkZXYsCisJCQkJY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgY29uc3Qgdm9pZCAq
YnVmKQoreworCWNvbnN0IHN0cnVjdCBoaWZfaW5kX2Vycm9yICpib2R5ID0gYnVmOworCWludCB0
eXBlID0gbGUzMl90b19jcHUoYm9keS0+dHlwZSk7CisJaW50IHBhcmFtID0gKHM4KWJvZHktPmRh
dGFbMF07CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShoaWZfZXJyb3Jz
KTsgaSsrKQorCQlpZiAodHlwZSA9PSBoaWZfZXJyb3JzW2ldLnZhbCkKKwkJCWJyZWFrOworCWlm
IChpIDwgQVJSQVlfU0laRShoaWZfZXJyb3JzKSkKKwkJaWYgKGhpZl9lcnJvcnNbaV0uaGFzX3Bh
cmFtKQorCQkJZGV2X2Vycih3ZGV2LT5kZXYsICJhc3luY2hyb25vdXMgZXJyb3I6ICVzOiAlZFxu
IiwKKwkJCQloaWZfZXJyb3JzW2ldLnN0ciwgcGFyYW0pOworCQllbHNlCisJCQlkZXZfZXJyKHdk
ZXYtPmRldiwgImFzeW5jaHJvbm91cyBlcnJvcjogJXNcbiIsCisJCQkJaGlmX2Vycm9yc1tpXS5z
dHIpOworCWVsc2UKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICJhc3luY2hyb25vdXMgZXJyb3I6IHVu
a25vd246ICUwOHhcbiIsIHR5cGUpOworCXByaW50X2hleF9kdW1wKEtFUk5fSU5GTywgImhpZjog
IiwgRFVNUF9QUkVGSVhfT0ZGU0VULAorCQkgICAgICAgMTYsIDEsIGhpZiwgbGUxNl90b19jcHUo
aGlmLT5sZW4pLCBmYWxzZSk7CisJd2Rldi0+Y2hpcF9mcm96ZW4gPSB0cnVlOworCisJcmV0dXJu
IDA7Cit9OworCitzdGF0aWMgaW50IGhpZl9leGNlcHRpb25faW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4
X2RldiAqd2RldiwKKwkJCQkgICAgY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgY29uc3Qgdm9p
ZCAqYnVmKQoreworCWNvbnN0IHN0cnVjdCBoaWZfaW5kX2V4Y2VwdGlvbiAqYm9keSA9IGJ1ZjsK
KwlpbnQgdHlwZSA9IGxlMzJfdG9fY3B1KGJvZHktPnR5cGUpOworCisJaWYgKHR5cGUgPT0gNCkK
KwkJZGV2X2Vycih3ZGV2LT5kZXYsICJmaXJtd2FyZSBhc3NlcnQgJWRcbiIsCisJCQlsZTMyX3Rv
X2NwdXAoKF9fbGUzMiAqKWJvZHktPmRhdGEpKTsKKwllbHNlCisJCWRldl9lcnIod2Rldi0+ZGV2
LCAiZmlybXdhcmUgZXhjZXB0aW9uXG4iKTsKKwlwcmludF9oZXhfZHVtcChLRVJOX0lORk8sICJo
aWY6ICIsIERVTVBfUFJFRklYX09GRlNFVCwKKwkJICAgICAgIDE2LCAxLCBoaWYsIGxlMTZfdG9f
Y3B1KGhpZi0+bGVuKSwgZmFsc2UpOworCXdkZXYtPmNoaXBfZnJvemVuID0gdHJ1ZTsKKworCXJl
dHVybiAtMTsKK30KKworc3RhdGljIGNvbnN0IHN0cnVjdCB7CisJaW50IG1zZ19pZDsKKwlpbnQg
KCpoYW5kbGVyKShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwKKwkJICAgICAgIGNvbnN0IHN0cnVjdCBo
aWZfbXNnICpoaWYsIGNvbnN0IHZvaWQgKmJ1Zik7Cit9IGhpZl9oYW5kbGVyc1tdID0geworCS8q
IENvbmZpcm1hdGlvbnMgKi8KKwl7IEhJRl9DTkZfSURfVFgsICAgICAgICAgICAgICAgICAgIGhp
Zl90eF9jb25maXJtIH0sCisJeyBISUZfQ05GX0lEX01VTFRJX1RSQU5TTUlULCAgICAgICBoaWZf
bXVsdGlfdHhfY29uZmlybSB9LAorCS8qIEluZGljYXRpb25zICovCisJeyBISUZfSU5EX0lEX1NU
QVJUVVAsICAgICAgICAgICAgICBoaWZfc3RhcnR1cF9pbmRpY2F0aW9uIH0sCisJeyBISUZfSU5E
X0lEX1dBS0VVUCwgICAgICAgICAgICAgICBoaWZfd2FrZXVwX2luZGljYXRpb24gfSwKKwl7IEhJ
Rl9JTkRfSURfSk9JTl9DT01QTEVURSwgICAgICAgIGhpZl9qb2luX2NvbXBsZXRlX2luZGljYXRp
b24gfSwKKwl7IEhJRl9JTkRfSURfU0VUX1BNX01PREVfQ01QTCwgICAgIGhpZl9wbV9tb2RlX2Nv
bXBsZXRlX2luZGljYXRpb24gfSwKKwl7IEhJRl9JTkRfSURfU0NBTl9DTVBMLCAgICAgICAgICAg
IGhpZl9zY2FuX2NvbXBsZXRlX2luZGljYXRpb24gfSwKKwl7IEhJRl9JTkRfSURfU1VTUEVORF9S
RVNVTUVfVFgsICAgIGhpZl9zdXNwZW5kX3Jlc3VtZV9pbmRpY2F0aW9uIH0sCisJeyBISUZfSU5E
X0lEX0VWRU5ULCAgICAgICAgICAgICAgICBoaWZfZXZlbnRfaW5kaWNhdGlvbiB9LAorCXsgSElG
X0lORF9JRF9HRU5FUklDLCAgICAgICAgICAgICAgaGlmX2dlbmVyaWNfaW5kaWNhdGlvbiB9LAor
CXsgSElGX0lORF9JRF9FUlJPUiwgICAgICAgICAgICAgICAgaGlmX2Vycm9yX2luZGljYXRpb24g
fSwKKwl7IEhJRl9JTkRfSURfRVhDRVBUSU9OLCAgICAgICAgICAgIGhpZl9leGNlcHRpb25faW5k
aWNhdGlvbiB9LAorCS8vIEZJWE1FOiBhbGxvY2F0ZSBza2JfcCBmcm9tIGhpZl9yZWNlaXZlX2lu
ZGljYXRpb24gYW5kIG1ha2UgaXQgZ2VuZXJpYworCS8veyBISUZfSU5EX0lEX1JYLCAgICAgICAg
ICAgICAgICAgaGlmX3JlY2VpdmVfaW5kaWNhdGlvbiB9LAorfTsKKwordm9pZCB3ZnhfaGFuZGxl
X3J4KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQoreworCWludCBp
OworCWNvbnN0IHN0cnVjdCBoaWZfbXNnICpoaWYgPSAoY29uc3Qgc3RydWN0IGhpZl9tc2cgKilz
a2ItPmRhdGE7CisJaW50IGhpZl9pZCA9IGhpZi0+aWQ7CisKKwlpZiAoaGlmX2lkID09IEhJRl9J
TkRfSURfUlgpIHsKKwkJLy8gaGlmX3JlY2VpdmVfaW5kaWNhdGlvbiB0YWtlIGNhcmUgb2Ygc2ti
IGxpZmV0aW1lCisJCWhpZl9yZWNlaXZlX2luZGljYXRpb24od2RldiwgaGlmLCBoaWYtPmJvZHks
IHNrYik7CisJCXJldHVybjsKKwl9CisJLy8gTm90ZTogbXV0ZXhfaXNfbG9jayBjYXVzZSBhbiBp
bXBsaWNpdCBtZW1vcnkgYmFycmllciB0aGF0IHByb3RlY3QKKwkvLyBidWZfc2VuZAorCWlmICht
dXRleF9pc19sb2NrZWQoJndkZXYtPmhpZl9jbWQubG9jaykKKwkgICAgJiYgd2Rldi0+aGlmX2Nt
ZC5idWZfc2VuZAorCSAgICAmJiB3ZGV2LT5oaWZfY21kLmJ1Zl9zZW5kLT5pZCA9PSBoaWZfaWQp
IHsKKwkJaGlmX2dlbmVyaWNfY29uZmlybSh3ZGV2LCBoaWYsIGhpZi0+Ym9keSk7CisJCWdvdG8g
ZnJlZTsKKwl9CisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoaGlmX2hhbmRsZXJzKTsgaSsr
KSB7CisJCWlmIChoaWZfaGFuZGxlcnNbaV0ubXNnX2lkID09IGhpZl9pZCkgeworCQkJaWYgKGhp
Zl9oYW5kbGVyc1tpXS5oYW5kbGVyKQorCQkJCWhpZl9oYW5kbGVyc1tpXS5oYW5kbGVyKHdkZXYs
IGhpZiwgaGlmLT5ib2R5KTsKKwkJCWdvdG8gZnJlZTsKKwkJfQorCX0KKwlpZiAoaGlmX2lkICYg
MHg4MCkKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICJ1bnN1cHBvcnRlZCBISUYgaW5kaWNhdGlvbjog
SUQgJTAyeFxuIiwKKwkJCWhpZl9pZCk7CisJZWxzZQorCQlkZXZfZXJyKHdkZXYtPmRldiwgInVu
ZXhwZWN0ZWQgSElGIGNvbmZpcm1hdGlvbjogSUQgJTAyeFxuIiwKKwkJCWhpZl9pZCk7CitmcmVl
OgorCWRldl9rZnJlZV9za2Ioc2tiKTsKK30KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3NpbGFicy93ZngvaGlmX3J4LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4
L2hpZl9yeC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uZjA3YzEw
YzhjNmJkCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dm
eC9oaWZfcnguaApAQCAtMCwwICsxLDE4IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vbmx5ICovCisvKgorICogSW1wbGVtZW50YXRpb24gb2YgY2hpcC10by1ob3N0IGV2
ZW50IChha2EgaW5kaWNhdGlvbnMpIG9mIFdGeHh4IFNwbGl0IE1hYworICogKFdTTSkgQVBJLgor
ICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDE5LCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5j
LgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICogQ29weXJpZ2h0IChDKSAy
MDEwLCBTVC1Fcmljc3NvbiBTQQorICovCisjaWZuZGVmIFdGWF9ISUZfUlhfSAorI2RlZmluZSBX
RlhfSElGX1JYX0gKKworc3RydWN0IHdmeF9kZXY7CitzdHJ1Y3Qgc2tfYnVmZjsKKwordm9pZCB3
ZnhfaGFuZGxlX3J4KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsK
KworI2VuZGlmCi0tIAoyLjI4LjAKCg==
