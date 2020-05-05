Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D71C55B3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgEEMjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 08:39:03 -0400
Received: from mail-eopbgr770049.outbound.protection.outlook.com ([40.107.77.49]:46720
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729164AbgEEMi5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 08:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqQ1K3LbL/e2LX/uZ0zEpArzeIV93EsIBRUCwnN3RQGPJAGrYscryb/BpxNflDHhl1WyXcMcaiQDycgIrJKvfYzE6On2Ab1LlpmbQuVXQgufUts8W1HxYcz8aG88M0Gy0djMnpxYWMrCLG+sQmdOKtYkQmmC7oe2oPEO2boLISBfjwXZFdS0CoEi077qe2igOL370rcMoMmlV2o2TnZWDbj63+VVCmTCLLpnP1GKHb23Ky0oTII1MjEqTopQi6RFby5GwLDajaXf+/92fP/CXNLfxxGhIcH91A/B5/PG2HYyWd6OjhZ6dQSxkoQcCKeHXFDd9MrTJ5TVBsbSX1Aw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q88NH/Z+Ghe/bbf7NcKlW2paRAvZh4tzX89eXQINv3k=;
 b=SB+645bXLcVzbJiOKG66csUigsyuf81YNo1Cs6+MO11lPaPG1Ryhq1Crw5huwsi8q78QY6aLNh1KXBC5d5GrspZWCKW9sG5pFA+4jMODQYIXEKA6cWFtv386EsIfAnOutadLs676kWLmhsvBDxke3yALSpqSQstc8fE7zrZX+Fnv3c/MTkKCpZ8VwT37VO+nvUrUAkhVobOshiHaC8ap1Z5d38wsRGm1eAw1s4YPL8Q8a5JIwnKFsv3eLBM9kXINxjAaNIGrjs0mcmyHz8SJG5S9qE80xLssHu59kJ1iIt7p8w4o1ysi4izbCUrUdlu0dj5I66q97QhN8Os96UIB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q88NH/Z+Ghe/bbf7NcKlW2paRAvZh4tzX89eXQINv3k=;
 b=Bc+zhF+tXyZ7Kknr21PHDyOu1b7RGyEyu3i44uaWqCusefje1KpuZHwKJ3KzPz9fZf4wDe7zDVtY4CyaajG4P8wfaIf0CAo7PazJzeF6c6/cqZN+PSlPxRF+6lpvTi1Ltsk36SkISe5+E1lNxM8dEYrHUo0QLHLY6fLty5CFMaA=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=silabs.com;
Received: from MWHPR11MB1775.namprd11.prod.outlook.com (2603:10b6:300:10e::14)
 by MWHPR11MB2046.namprd11.prod.outlook.com (2603:10b6:300:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 12:38:42 +0000
Received: from MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::81d5:b62b:3770:ffbe]) by MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::81d5:b62b:3770:ffbe%10]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 12:38:42 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 14/15] staging: wfx: remove spaces after cast operator
Date:   Tue,  5 May 2020 14:37:56 +0200
Message-Id: <20200505123757.39506-15-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200505123757.39506-1-Jerome.Pouiller@silabs.com>
References: <20200505123757.39506-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR3P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::27) To MWHPR11MB1775.namprd11.prod.outlook.com
 (2603:10b6:300:10e::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.home (2a01:e35:2435:66a0:1265:30ff:fefd:6e7f) by PR3P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 12:38:40 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [2a01:e35:2435:66a0:1265:30ff:fefd:6e7f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d97d77ea-cee9-4446-26c6-08d7f0f13e75
X-MS-TrafficTypeDiagnostic: MWHPR11MB2046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB2046E6BB064B8442F81D673893A70@MWHPR11MB2046.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zj73ms6HDqQftp52Si40A33exkJetqINTYDMOal0gRQCkep+dPOFjFGwGxfIS3AMnwlsFoSy4hVRcVmWKqpyr8CZe/9MfzCm1e/0qXa40oap5t6IuIiStY82+4BhjAC3OBeEpo78Oq1t+Uq+VEfjpaGXvFheppDw1Nlo7WKAHLacsQoM1creXeiR7MZtJZTVqS+LCVlk4dy0lk7e6Cx74XMYaoU/sSbWjh3/gaLibhl2USNi85GXaTWoqBcPwiF6PkygRVGdj8+W6qh4+3yph/R76tmkGcN6+b7JXzqGBU87Xoh7O9MIKNGm6YZ8VKOC6ChhKO97cYHWt3Nv8IFJvSIXLpnrWexEr7If3kF4xgnzPdLmnW+DYY4d//nSLZdeZd5cH44MMaZHY+C0hKsZ+Xzj+HvChtmg9yx9YmI+nlisfH7CLTPHYTqHQlZNO26H9RhpHBf42ekGhSvMHmqiUL8AdkyATtbm1r2xrQucdAg+l26WrajslWUh1F1Q/Ohznf3iPgOMQIBqG9l9OocfAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(39850400004)(136003)(376002)(33430700001)(2906002)(36756003)(52116002)(86362001)(5660300002)(6486002)(1076003)(8676002)(66574012)(8936002)(6666004)(107886003)(2616005)(66476007)(66946007)(16526019)(186003)(66556008)(6512007)(8886007)(478600001)(4326008)(6506007)(33440700001)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LK8YBSCFoy8TtPSPsINb7kkeWg12v+iN1/5TRhZVLcQ+TFuPMenM0dUWdRod9JCkrpCzT6rsCME/XbqNgkEhNzKJy4on8c5VLW9HNrQBxTUnDRpD/44HTlk9lEyB3PLE37U+459eod8BrEjlc8wUnrFr4jET2VHHf5kcJZxtr3LnUP1tQUwx2rBHUZH5wxLXe5H5w2ymGAVaaVXueCk8HEeiPv2pI48wUCp+jUwoJaf3VOsS2VEJks+gs4jHxfvzdrJDs0P7yPOueLMRqlJWbe80mncU7RV+Mx2o+z57A/YnOnOStDd9YPo57ewCt/09kBrZXBFtsgTYFhynhKH8g4+zhnNYc8dvb0z6Q05VQQZ82GmxsZ12fb2zurSspS/CJ9BHa2nvXyAb88Xehqh1jX3aQhgM4WusTVHNXwfazqfmsItkWPGHbuZQBWZTDAv1DsPIJELdsAfrAcWNzKATEP6FkmY3yuazuyadvhqMRiU6FLbny2R4yqtX+3V4UGTTjT7RyzphC43nS1WuiRyeEFwyEG2HD9+ki0ASf3vXuikQqcN8KVqhUc6D9LniNedLA8WRbqNqW/aLR4CPkyhxc0H3hx7lMi+FUewPwXcXv2fRjTH7PqY2HsaJ9o83Wc3PwBRKlWsWrw0Z+Oh3ZLMeC1x4fYoPXPQtBOjEzFbLhXt2u2hHDqWxyQbkz7ncniIYFWyZI+zjS+GC8IciFX34aXmfi6WPr/c8qs7Yctu54wtFY/6eJO/cAgvvNrg3vYMCreGakCcrXcq9T7bVvfzJLaq8erkW6/GmGiJCpK1VCggZFAaMQkJsNxosb55Jd7bU4+2joXInzjDE01B9tvHJB48u8NsGVAuhXg7ESwo2Hzs=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97d77ea-cee9-4446-26c6-08d7f0f13e75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 12:38:42.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcQdWbMM3HseddVnwPA4JQdtI6sGZ+EVliz6RhwIgmNE8iGMzKCerDDuXkDqGzl6JcS+nVD+405/MRaBHlin8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2046
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKVGhl
IGtlcm5lbCBjb2Rpbmcgc3R5bGUgZXhwZWN0cyBubyBzcGFjZSBhZnRlciBjYXN0IG9wZXJhdG9y
LiBUaGlzIHBhdGNoCm1ha2UgdGhlIHdmeCBkcml2ZXIgY29tcGxpYW50IHdpdGggdGhpcyBydWxl
LgoKU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxh
YnMuY29tPgotLS0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3J4LmMgfCAgMiArLQogZHJpdmVy
cy9zdGFnaW5nL3dmeC9oaWZfdHguYyB8ICA0ICsrLS0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaHdp
by5jICAgfCAgNCArKy0tCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2tleS5jICAgIHwgIDIgKy0KIGRy
aXZlcnMvc3RhZ2luZy93ZngvbWFpbi5jICAgfCAgMiArLQogZHJpdmVycy9zdGFnaW5nL3dmeC9z
dGEuYyAgICB8IDIzICsrKysrKysrKysrLS0tLS0tLS0tLS0tCiA2IGZpbGVzIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Rh
Z2luZy93ZngvaGlmX3J4LmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9yeC5jCmluZGV4IGI3
ODY3MTRhODc1NS4uYWM0ZWM0ZjMwNDk2IDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4
L2hpZl9yeC5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3J4LmMKQEAgLTI2Myw3ICsy
NjMsNyBAQCBzdGF0aWMgaW50IGhpZl9nZW5lcmljX2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYg
KndkZXYsCiAJCXJldHVybiAwOwogCWNhc2UgSElGX0dFTkVSSUNfSU5ESUNBVElPTl9UWVBFX1NU
UklORzoKIAkJZGV2X2luZm8od2Rldi0+ZGV2LCAiZmlybXdhcmUgc2F5czogJXNcbiIsCi0JCQkg
KGNoYXIgKikgYm9keS0+aW5kaWNhdGlvbl9kYXRhLnJhd19kYXRhKTsKKwkJCSAoY2hhciAqKWJv
ZHktPmluZGljYXRpb25fZGF0YS5yYXdfZGF0YSk7CiAJCXJldHVybiAwOwogCWNhc2UgSElGX0dF
TkVSSUNfSU5ESUNBVElPTl9UWVBFX1JYX1NUQVRTOgogCQltdXRleF9sb2NrKCZ3ZGV2LT5yeF9z
dGF0c19sb2NrKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4LmMgYi9k
cml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eC5jCmluZGV4IDk2ZjEzZDljOGM5OC4uYjA4M2ZjYWNl
MzAzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eC5jCisrKyBiL2RyaXZl
cnMvc3RhZ2luZy93ZngvaGlmX3R4LmMKQEAgLTEwNiw3ICsxMDYsNyBAQCBpbnQgd2Z4X2NtZF9z
ZW5kKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAqcmVxdWVzdCwKIAogCWlm
IChyZXQgJiYKIAkgICAgKGNtZCA9PSBISUZfUkVRX0lEX1JFQURfTUlCIHx8IGNtZCA9PSBISUZf
UkVRX0lEX1dSSVRFX01JQikpIHsKLQkJbWliX25hbWUgPSBnZXRfbWliX25hbWUoKCh1MTYgKikg
cmVxdWVzdClbMl0pOworCQltaWJfbmFtZSA9IGdldF9taWJfbmFtZSgoKHUxNiAqKXJlcXVlc3Qp
WzJdKTsKIAkJbWliX3NlcCA9ICIvIjsKIAl9CiAJaWYgKHJldCA8IDApCkBAIC00NzAsNyArNDcw
LDcgQEAgaW50IGhpZl9tYXBfbGluayhzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgdTggKm1hY19hZGRy
LCBpbnQgZmxhZ3MsIGludCBzdGFfaWQpCiAKIAlpZiAobWFjX2FkZHIpCiAJCWV0aGVyX2FkZHJf
Y29weShib2R5LT5tYWNfYWRkciwgbWFjX2FkZHIpOwotCWJvZHktPm1hcF9saW5rX2ZsYWdzID0g
KihzdHJ1Y3QgaGlmX21hcF9saW5rX2ZsYWdzICopICZmbGFnczsKKwlib2R5LT5tYXBfbGlua19m
bGFncyA9ICooc3RydWN0IGhpZl9tYXBfbGlua19mbGFncyAqKSZmbGFnczsKIAlib2R5LT5wZWVy
X3N0YV9pZCA9IHN0YV9pZDsKIAl3ZnhfZmlsbF9oZWFkZXIoaGlmLCB3dmlmLT5pZCwgSElGX1JF
UV9JRF9NQVBfTElOSywgc2l6ZW9mKCpib2R5KSk7CiAJcmV0ID0gd2Z4X2NtZF9zZW5kKHd2aWYt
PndkZXYsIGhpZiwgTlVMTCwgMCwgZmFsc2UpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5n
L3dmeC9od2lvLmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2h3aW8uYwppbmRleCAwNTFkNGIyMzNi
NDcuLmQ4NzhjYjNlODRmYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9od2lvLmMK
KysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9od2lvLmMKQEAgLTIzMyw3ICsyMzMsNyBAQCBpbnQg
d2Z4X2RhdGFfcmVhZChzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgdm9pZCAqYnVmLCBzaXplX3QgbGVu
KQogewogCWludCByZXQ7CiAKLQlXQVJOKChsb25nKSBidWYgJiAzLCAiJXM6IHVuYWxpZ25lZCBi
dWZmZXIiLCBfX2Z1bmNfXyk7CisJV0FSTigobG9uZylidWYgJiAzLCAiJXM6IHVuYWxpZ25lZCBi
dWZmZXIiLCBfX2Z1bmNfXyk7CiAJd2Rldi0+aHdidXNfb3BzLT5sb2NrKHdkZXYtPmh3YnVzX3By
aXYpOwogCXJldCA9IHdkZXYtPmh3YnVzX29wcy0+Y29weV9mcm9tX2lvKHdkZXYtPmh3YnVzX3By
aXYsCiAJCQkJCSAgICBXRlhfUkVHX0lOX09VVF9RVUVVRSwgYnVmLCBsZW4pOwpAQCAtMjQ5LDcg
KzI0OSw3IEBAIGludCB3ZnhfZGF0YV93cml0ZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgY29uc3Qg
dm9pZCAqYnVmLCBzaXplX3QgbGVuKQogewogCWludCByZXQ7CiAKLQlXQVJOKChsb25nKSBidWYg
JiAzLCAiJXM6IHVuYWxpZ25lZCBidWZmZXIiLCBfX2Z1bmNfXyk7CisJV0FSTigobG9uZylidWYg
JiAzLCAiJXM6IHVuYWxpZ25lZCBidWZmZXIiLCBfX2Z1bmNfXyk7CiAJd2Rldi0+aHdidXNfb3Bz
LT5sb2NrKHdkZXYtPmh3YnVzX3ByaXYpOwogCXJldCA9IHdkZXYtPmh3YnVzX29wcy0+Y29weV90
b19pbyh3ZGV2LT5od2J1c19wcml2LAogCQkJCQkgIFdGWF9SRUdfSU5fT1VUX1FVRVVFLCBidWYs
IGxlbik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2tleS5jIGIvZHJpdmVycy9z
dGFnaW5nL3dmeC9rZXkuYwppbmRleCBjZWI1N2NiZGZlZmQuLjVlZTJmZmM1ZjkzNSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9rZXkuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4
L2tleS5jCkBAIC0yMjgsNyArMjI4LDcgQEAgaW50IHdmeF9zZXRfa2V5KHN0cnVjdCBpZWVlODAy
MTFfaHcgKmh3LCBlbnVtIHNldF9rZXlfY21kIGNtZCwKIAkJc3RydWN0IGllZWU4MDIxMV9rZXlf
Y29uZiAqa2V5KQogewogCWludCByZXQgPSAtRU9QTk9UU1VQUDsKLQlzdHJ1Y3Qgd2Z4X3ZpZiAq
d3ZpZiA9IChzdHJ1Y3Qgd2Z4X3ZpZiAqKSB2aWYtPmRydl9wcml2OworCXN0cnVjdCB3Znhfdmlm
ICp3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKIAogCW11dGV4X2xvY2so
Jnd2aWYtPndkZXYtPmNvbmZfbXV0ZXgpOwogCWlmIChjbWQgPT0gU0VUX0tFWSkKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9tYWlu
LmMKaW5kZXggZGU0MWYxNjcxNDMzLi4xOGM5NmI4MmM2NmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
c3RhZ2luZy93ZngvbWFpbi5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5jCkBAIC0z
OTAsNyArMzkwLDcgQEAgaW50IHdmeF9wcm9iZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldikKIAkJIHdk
ZXYtPmh3X2NhcHMuZmlybXdhcmVfYnVpbGQsIHdkZXYtPmh3X2NhcHMuZmlybXdhcmVfbGFiZWws
CiAJCSB3ZGV2LT5od19jYXBzLmFwaV92ZXJzaW9uX21ham9yLAogCQkgd2Rldi0+aHdfY2Fwcy5h
cGlfdmVyc2lvbl9taW5vciwKLQkJIHdkZXYtPmtleXNldCwgKigodTMyICopICZ3ZGV2LT5od19j
YXBzLmNhcGFiaWxpdGllcykpOworCQkgd2Rldi0+a2V5c2V0LCAqKCh1MzIgKikmd2Rldi0+aHdf
Y2Fwcy5jYXBhYmlsaXRpZXMpKTsKIAlzbnByaW50Zih3ZGV2LT5ody0+d2lwaHktPmZ3X3ZlcnNp
b24sCiAJCSBzaXplb2Yod2Rldi0+aHctPndpcGh5LT5md192ZXJzaW9uKSwKIAkJICIlZC4lZC4l
ZCIsCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5jIGIvZHJpdmVycy9zdGFn
aW5nL3dmeC9zdGEuYwppbmRleCA5OTllMGYwZTE5YWYuLjFhODc2YTBmYWFmNSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L3N0
YS5jCkBAIC0yNTEsNyArMjUxLDcgQEAgaW50IHdmeF9jb25mX3R4KHN0cnVjdCBpZWVlODAyMTFf
aHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAogCQkgICB1MTYgcXVldWUsIGNvbnN0
IHN0cnVjdCBpZWVlODAyMTFfdHhfcXVldWVfcGFyYW1zICpwYXJhbXMpCiB7CiAJc3RydWN0IHdm
eF9kZXYgKndkZXYgPSBody0+cHJpdjsKLQlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IChzdHJ1Y3Qg
d2Z4X3ZpZiAqKSB2aWYtPmRydl9wcml2OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gKHN0cnVj
dCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKIAlpbnQgb2xkX3VhcHNkID0gd3ZpZi0+dWFwc2Rf
bWFzazsKIAogCVdBUk5fT04ocXVldWUgPj0gaHctPnF1ZXVlcyk7CkBAIC0zNDUsOCArMzQ1LDcg
QEAgc3RhdGljIHZvaWQgd2Z4X3NldF9tZnAoc3RydWN0IHdmeF92aWYgKnd2aWYsCiAKIAlyY3Vf
cmVhZF9sb2NrKCk7CiAJaWYgKGJzcykKLQkJcHRyID0gKGNvbnN0IHUxNiAqKSBpZWVlODAyMTFf
YnNzX2dldF9pZShic3MsCi0JCQkJCQkJICAgICAgV0xBTl9FSURfUlNOKTsKKwkJcHRyID0gKGNv
bnN0IHUxNiAqKWllZWU4MDIxMV9ic3NfZ2V0X2llKGJzcywgV0xBTl9FSURfUlNOKTsKIAogCWlm
IChwdHIpIHsKIAkJcHRyICs9IHBhaXJ3aXNlX2NpcGhlcl9zdWl0ZV9jb3VudF9vZmZzZXQ7CkBA
IC00MTEsOCArNDEwLDggQEAgc3RhdGljIHZvaWQgd2Z4X2RvX2pvaW4oc3RydWN0IHdmeF92aWYg
Knd2aWYpCiBpbnQgd2Z4X3N0YV9hZGQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBp
ZWVlODAyMTFfdmlmICp2aWYsCiAJCXN0cnVjdCBpZWVlODAyMTFfc3RhICpzdGEpCiB7Ci0Jc3Ry
dWN0IHdmeF92aWYgKnd2aWYgPSAoc3RydWN0IHdmeF92aWYgKikgdmlmLT5kcnZfcHJpdjsKLQlz
dHJ1Y3Qgd2Z4X3N0YV9wcml2ICpzdGFfcHJpdiA9IChzdHJ1Y3Qgd2Z4X3N0YV9wcml2ICopICZz
dGEtPmRydl9wcml2OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICop
dmlmLT5kcnZfcHJpdjsKKwlzdHJ1Y3Qgd2Z4X3N0YV9wcml2ICpzdGFfcHJpdiA9IChzdHJ1Y3Qg
d2Z4X3N0YV9wcml2ICopJnN0YS0+ZHJ2X3ByaXY7CiAKIAlzcGluX2xvY2tfaW5pdCgmc3RhX3By
aXYtPmxvY2spOwogCXN0YV9wcml2LT52aWZfaWQgPSB3dmlmLT5pZDsKQEAgLTQzMiw4ICs0MzEs
OCBAQCBpbnQgd2Z4X3N0YV9hZGQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYsCiBpbnQgd2Z4X3N0YV9yZW1vdmUoc3RydWN0IGllZWU4MDIxMV9odyAq
aHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCiAJCSAgIHN0cnVjdCBpZWVlODAyMTFfc3Rh
ICpzdGEpCiB7Ci0Jc3RydWN0IHdmeF92aWYgKnd2aWYgPSAoc3RydWN0IHdmeF92aWYgKikgdmlm
LT5kcnZfcHJpdjsKLQlzdHJ1Y3Qgd2Z4X3N0YV9wcml2ICpzdGFfcHJpdiA9IChzdHJ1Y3Qgd2Z4
X3N0YV9wcml2ICopICZzdGEtPmRydl9wcml2OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gKHN0
cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKKwlzdHJ1Y3Qgd2Z4X3N0YV9wcml2ICpzdGFf
cHJpdiA9IChzdHJ1Y3Qgd2Z4X3N0YV9wcml2ICopJnN0YS0+ZHJ2X3ByaXY7CiAJaW50IGk7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzdGFfcHJpdi0+YnVmZmVyZWQpOyBpKyspCkBA
IC01MzQsNyArNTMzLDcgQEAgdm9pZCB3ZnhfYnNzX2luZm9fY2hhbmdlZChzdHJ1Y3QgaWVlZTgw
MjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIAkJCSAgc3RydWN0IGllZWU4
MDIxMV9ic3NfY29uZiAqaW5mbywgdTMyIGNoYW5nZWQpCiB7CiAJc3RydWN0IHdmeF9kZXYgKndk
ZXYgPSBody0+cHJpdjsKLQlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IChzdHJ1Y3Qgd2Z4X3ZpZiAq
KSB2aWYtPmRydl9wcml2OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gKHN0cnVjdCB3Znhfdmlm
ICopdmlmLT5kcnZfcHJpdjsKIAlpbnQgaTsKIAogCW11dGV4X2xvY2soJndkZXYtPmNvbmZfbXV0
ZXgpOwpAQCAtNzAzLDcgKzcwMiw3IEBAIHZvaWQgd2Z4X2NoYW5nZV9jaGFuY3R4KHN0cnVjdCBp
ZWVlODAyMTFfaHcgKmh3LAogaW50IHdmeF9hc3NpZ25fdmlmX2NoYW5jdHgoc3RydWN0IGllZWU4
MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCiAJCQkgICBzdHJ1Y3QgaWVl
ZTgwMjExX2NoYW5jdHhfY29uZiAqY29uZikKIHsKLQlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IChz
dHJ1Y3Qgd2Z4X3ZpZiAqKSB2aWYtPmRydl9wcml2OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0g
KHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKIAlzdHJ1Y3QgaWVlZTgwMjExX2NoYW5u
ZWwgKmNoID0gY29uZi0+ZGVmLmNoYW47CiAKIAlXQVJOKHd2aWYtPmNoYW5uZWwsICJjaGFubmVs
IG92ZXJ3cml0ZSIpOwpAQCAtNzE2LDcgKzcxNSw3IEBAIHZvaWQgd2Z4X3VuYXNzaWduX3ZpZl9j
aGFuY3R4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LAogCQkJICAgICAgc3RydWN0IGllZWU4MDIx
MV92aWYgKnZpZiwKIAkJCSAgICAgIHN0cnVjdCBpZWVlODAyMTFfY2hhbmN0eF9jb25mICpjb25m
KQogewotCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopIHZpZi0+ZHJ2
X3ByaXY7CisJc3RydWN0IHdmeF92aWYgKnd2aWYgPSAoc3RydWN0IHdmeF92aWYgKil2aWYtPmRy
dl9wcml2OwogCXN0cnVjdCBpZWVlODAyMTFfY2hhbm5lbCAqY2ggPSBjb25mLT5kZWYuY2hhbjsK
IAogCVdBUk4od3ZpZi0+Y2hhbm5lbCAhPSBjaCwgImNoYW5uZWwgbWlzbWF0Y2giKTsKQEAgLTcz
Miw3ICs3MzEsNyBAQCBpbnQgd2Z4X2FkZF9pbnRlcmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAq
aHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpCiB7CiAJaW50IGksIHJldCA9IDA7CiAJc3Ry
dWN0IHdmeF9kZXYgKndkZXYgPSBody0+cHJpdjsKLQlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IChz
dHJ1Y3Qgd2Z4X3ZpZiAqKSB2aWYtPmRydl9wcml2OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0g
KHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKIAogCXZpZi0+ZHJpdmVyX2ZsYWdzIHw9
IElFRUU4MDIxMV9WSUZfQkVBQ09OX0ZJTFRFUiB8CiAJCQkgICAgIElFRUU4MDIxMV9WSUZfU1VQ
UE9SVFNfVUFQU0QgfApAQCAtNzk5LDcgKzc5OCw3IEBAIGludCB3ZnhfYWRkX2ludGVyZmFjZShz
dHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZikKIHZvaWQg
d2Z4X3JlbW92ZV9pbnRlcmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYpCiB7CiAJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBody0+cHJpdjsKLQlz
dHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IChzdHJ1Y3Qgd2Z4X3ZpZiAqKSB2aWYtPmRydl9wcml2Owor
CXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsK
IAogCXdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmd3ZpZi0+c2V0X3BtX21vZGVfY29tcGxl
dGUsIG1zZWNzX3RvX2ppZmZpZXMoMzAwKSk7CiAKLS0gCjIuMjYuMQoK
