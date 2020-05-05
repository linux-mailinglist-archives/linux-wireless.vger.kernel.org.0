Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31281C55A5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgEEMix (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 08:38:53 -0400
Received: from mail-eopbgr680041.outbound.protection.outlook.com ([40.107.68.41]:21169
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729115AbgEEMit (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 08:38:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etgiWBhro+wph3OPL7GQU72jCaRqNP2xFwF9kYjCsYMozpmqYkK7wIMTu0fJbQZRGhRBgK4D4/xQbQniy5flt7dAZBTUX7IXaXY21xBKuaD1ntcz0fzMtNOJHIJ5NYkl1PmceyO7zUNvW2ibDqKWDbqpZyxe0y2vECpCwQ7XcTXqWzYC52DcyRh9ogWG0+LPrmoe/CkDvHNTDsOh/MOQ269mVDSopKQjlj7RfR5YTZSdCs4EZK7aZhWc0tnTbYkWxpswPA57tdh9TeeC4ur5C32R5xkx9610Vml6wHBapfo3g1C57Zp8tP70xr5ahWuHlm3/bRD0xhrM6qDyGP2j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GBNkwWw5Z5Rrd13zcIw/+v6k11pKV8yRE+roAUh8OA=;
 b=Ae4BSRe5ef/xTE2PSqmgLbBJMtaoh295GPcNB1LLj7oVYTQ4ygal3m9A2asGdI52sZKC091Q01hK7tvAivIPCCGJAAJGcBmliYri6xd7HR0P4YwIuA3yjIHipV0illGOSWrseoruWeMZf6jqcC+KS2/nQK9NAV4zOwwssBXU9vsgQ3b8AjdGSO0CvLDwfJTEXo5wU60lIo9mniNjrpx4NFst5RI4eTgr2k2e73Lyahfsd2P7cEdnyjc1IuzIodV75chKj6dSZEn0icIfGCskaJUQNi0YrfIP9/e8+h/xAVmI89/k38iE5pXEPrio9UxsnL51jYbb/Are84zgq4QhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GBNkwWw5Z5Rrd13zcIw/+v6k11pKV8yRE+roAUh8OA=;
 b=I+O6OaWrnkAm/3oqGhja7Y/op97u0V8pECLNeHPi4YudhpmeEXthq9pnnYrrs3jPFHbDzfesRXwDrciU/NmssQMXPnM/SMbtNddKQMsSf+4IGh5TyGTU3r4rfZyQ4pDTXyi2TgyJSKnQPRzG0QXg6tbvaMJSWSCTBvMflKfLfQY=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=silabs.com;
Received: from MWHPR11MB1775.namprd11.prod.outlook.com (2603:10b6:300:10e::14)
 by MWHPR11MB1824.namprd11.prod.outlook.com (2603:10b6:300:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Tue, 5 May
 2020 12:38:29 +0000
Received: from MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::81d5:b62b:3770:ffbe]) by MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::81d5:b62b:3770:ffbe%10]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 12:38:29 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 08/15] staging: wfx: poll IRQ during init
Date:   Tue,  5 May 2020 14:37:50 +0200
Message-Id: <20200505123757.39506-9-Jerome.Pouiller@silabs.com>
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
Received: from pc-42.home (2a01:e35:2435:66a0:1265:30ff:fefd:6e7f) by PR3P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 12:38:27 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [2a01:e35:2435:66a0:1265:30ff:fefd:6e7f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3a155c8-c047-4d54-0166-08d7f0f1365d
X-MS-TrafficTypeDiagnostic: MWHPR11MB1824:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB1824A862EE48BEE2E4EE782693A70@MWHPR11MB1824.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iipnSn1CoMXDyCKQvRv1RP3NnjYX/8jJD6uq8Kx/fXW8dMY1YOAo8ZfTgMCz94x0t2W9lC3vrRmQkRLzL5iP5ZeVQCdHpOQVy5An4kItAb31W5I9BWTUKmlYRxK+5ikGjZ7t+dWO7Ft8EV5r54E7ou2TSj+haSbJ7pH6dvQDLsGeh4koDiMSfHNkPLVVI1r2h+L8u423MEZ6GLrRXBWFxUr0w0r8g71SfAbMLCfxvk8TRJQHF+2mMRL2eQwO6N5w3KMp7S0AvBBQa00RQA4nTJmp+gcWA5Vz7gp+fQXzlDc5meoK/xqO0wWBqxEkBJIQSYPRpoL5y4/Mx3VN4athgzaGIsBMTRLruOdhZEvJV+8qFFn8f3NV6/g17lj3ewymMbDMXnY5DiwKaVi4N1m8B+5epvaq9Y1AxWOXmvhPddm/E1QW223UEEBuAEjvF1YnKnp70KEbuWLS4apMllf5MpIExwJio8J6PM5JQsDJi1ULkTWHLOD74G5VdUOpWMjaNngv8kOQirU2/wzeE+4+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39850400004)(366004)(376002)(346002)(33430700001)(86362001)(6666004)(107886003)(8886007)(1076003)(6512007)(6486002)(66574012)(36756003)(5660300002)(2906002)(66476007)(6506007)(16526019)(186003)(52116002)(66946007)(66556008)(54906003)(2616005)(4326008)(8936002)(8676002)(316002)(33440700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N2vCM2cnG5r18aMZEGxDh8x8bYwJFa7H2qmzjtqOz1AZCbTna9CG49kU/TMphkF98gQ8Fh9+ufSZpi7dQWtKWkOG1RIU7r87I+xKHLHGhHEKOxw3NIYN55DCsgDzmK7MK7Aqc+xjfKwis5vy1EL/onZImKSx9gDHHFLpqgqllLBfX1UwyazithzPza8jKUKR660C3h9dcFfU/bKRT6Y101O+c4qfHe/URbsT1ecvix4MizSmDxKRQPFzomjeSpRS01sGvu+6JVpLVwCYZbKvVZfy3qLuQCETvFUp5N+4Ln+Z4TIO0DgEZYnv9N4DKIBVClW7ceeleIpOWmY/3wuFSkmZFga4UUM9/GXnyYBgPgEdtmK5wYhbT3KmQsJcSG3/r5/PyangNCRt2J2bU5mdtTlhi8XtY347kOIAH2n/YY/QnB/V9h+rNQqAByrmiMtt5AztQLNdj8gMnIZ/uIgbDHoyG9Mi6xETj8urlM69bZeKd6ZdEfYxK4I0VM135K7qcYWqfKART8HSyoirxTfdRyydu2oEIqz2GYBG+1jRucLPvssKBF3w3Eo3y9u+wM4JZRTR3TxcksZu8MAZnLPmiT1ZZFt25u/clYIKmtBkl470YtLyP3UX3sYEl8GQ585HXo5LdNZG+Ymtz9Quah1T1vRGlYEVhl5GyTlMKCBE2q8Pwjgc0GqByzQtYSwL1LjvA+VjulLMIioiD2FLpMQjesReO4jwxdt46W4PkJ5X295gbG4T30K48MoxnMBZaJ6RhLlDyMXpWEH08Oeoglq/6xkG/yCyh2XT1zWzAPsL3TZQw2MRdzeGKPOH0NKDrfFumfZakf/ArR7EmuiRyGZtj+N7CjBE2gZtcs1Zn6wSyys=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a155c8-c047-4d54-0166-08d7f0f1365d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 12:38:29.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eK8Bbfcd8Po+Aq1vEKEJPeVYrVtvnuA1ga3yx5rr+VtnAf/9Xg75tZpEWgIXuj8Bx9M2/Z9VlwKK/+3fHm4MAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1824
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKV2hl
biB0aGUgY2hpcCBzdGFydHMgaW4gU0RJTyBtb2RlLCB0aGUgZXh0ZXJuYWwgSVJRIChha2EgT3V0
LU9mLUJhbmQKSVJRKSBjYW5ub3QgYmUgdXNlZCBiZWZvcmUgdG8gY29uZmlndXJlIGl0LiBUaGVy
ZWZvcmUsIHRoZSBmaXJzdApleGNoYW5nZXMgd2l0aCB0aGUgY2hpcCBoYXZlIHRvIGJlIGRvbmUg
d2l0aG91dCB0aGUgT09CIElSUS4KClRoaXMgcGF0Y2ggYWxsb3cgdG8gcG9sbCB0aGUgZGF0YSB1
bnRpbCB0aGUgT09CIElSUSBpcyBjb3JyZWN0bHkgc2V0dXAuCkluIG9yZGVyIHRvIGtlZXAgdGhl
IGNvZGUgc2ltcGxlciwgdGhpcyBwYXRjaCBhbHNvIHBvbGwgZGF0YSBldmVuIGlmIE9PQgpJUlEg
aXMgbm90IHVzZWQuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBv
dWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVycy9zdGFnaW5nL3dmeC9iaC5jICAgICAgIHwg
IDEgKwogZHJpdmVycy9zdGFnaW5nL3dmeC9idXMuaCAgICAgIHwgIDIgKysKIGRyaXZlcnMvc3Rh
Z2luZy93ZngvYnVzX3NkaW8uYyB8IDE3ICsrKysrKystLS0tLS0tLS0tCiBkcml2ZXJzL3N0YWdp
bmcvd2Z4L2J1c19zcGkuYyAgfCAxNiArKysrKysrKysrKysrLS0tCiBkcml2ZXJzL3N0YWdpbmcv
d2Z4L2hpZl90eC5jICAgfCAgMyArKysKIGRyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5jICAgICB8
IDI4ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KIGRyaXZlcnMvc3RhZ2luZy93Zngvd2Z4
LmggICAgICB8ICAxICsKIDcgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMjEgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9iaC5jIGIvZHJpdmVy
cy9zdGFnaW5nL3dmeC9iaC5jCmluZGV4IGQzZTdlZWQ4OWMzOC4uMjU3MmZiY2YxYTMzIDEwMDY0
NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2JoLmMKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dm
eC9iaC5jCkBAIC0zMjAsNiArMzIwLDcgQEAgdm9pZCB3ZnhfYmhfcG9sbF9pcnEoc3RydWN0IHdm
eF9kZXYgKndkZXYpCiAJa3RpbWVfdCBub3csIHN0YXJ0OwogCXUzMiByZWc7CiAKKwlXQVJOKCF3
ZGV2LT5wb2xsX2lycSwgInVuZXhwZWN0ZWQgSVJRIHBvbGxpbmcgY2FuIG1hc2sgSVJRIik7CiAJ
c3RhcnQgPSBrdGltZV9nZXQoKTsKIAlmb3IgKDs7KSB7CiAJCWNvbnRyb2xfcmVnX3JlYWQod2Rl
diwgJnJlZyk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2J1cy5oIGIvZHJpdmVy
cy9zdGFnaW5nL3dmeC9idXMuaAppbmRleCA2MmQ2ZWNhYmU0Y2IuLjAzNzBiNmM1OTg2MyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9idXMuaAorKysgYi9kcml2ZXJzL3N0YWdpbmcv
d2Z4L2J1cy5oCkBAIC0yNSw2ICsyNSw4IEBAIHN0cnVjdCBod2J1c19vcHMgewogCQkJICAgIHZv
aWQgKmRzdCwgc2l6ZV90IGNvdW50KTsKIAlpbnQgKCpjb3B5X3RvX2lvKSh2b2lkICpidXNfcHJp
diwgdW5zaWduZWQgaW50IGFkZHIsCiAJCQkgIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGNvdW50
KTsKKwlpbnQgKCppcnFfc3Vic2NyaWJlKSh2b2lkICpidXNfcHJpdik7CisJaW50ICgqaXJxX3Vu
c3Vic2NyaWJlKSh2b2lkICpidXNfcHJpdik7CiAJdm9pZCAoKmxvY2spKHZvaWQgKmJ1c19wcml2
KTsKIAl2b2lkICgqdW5sb2NrKSh2b2lkICpidXNfcHJpdik7CiAJc2l6ZV90ICgqYWxpZ25fc2l6
ZSkodm9pZCAqYnVzX3ByaXYsIHNpemVfdCBzaXplKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Rh
Z2luZy93ZngvYnVzX3NkaW8uYyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NkaW8uYwppbmRl
eCAyZjc4MjEyMGU0MzguLjZhZmRlMjM0OTI4OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5n
L3dmeC9idXNfc2Rpby5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NkaW8uYwpAQCAt
MTA2LDggKzEwNiw5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCB3Znhfc2Rpb19pcnFfaGFuZGxlcl9l
eHQoaW50IGlycSwgdm9pZCAqcHJpdikKIAlyZXR1cm4gSVJRX0hBTkRMRUQ7CiB9CiAKLXN0YXRp
YyBpbnQgd2Z4X3NkaW9faXJxX3N1YnNjcmliZShzdHJ1Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzKQor
c3RhdGljIGludCB3Znhfc2Rpb19pcnFfc3Vic2NyaWJlKHZvaWQgKnByaXYpCiB7CisJc3RydWN0
IHdmeF9zZGlvX3ByaXYgKmJ1cyA9IHByaXY7CiAJdTMyIGZsYWdzOwogCWludCByZXQ7CiAJdTgg
Y2NjcjsKQEAgLTEzNCw4ICsxMzUsOSBAQCBzdGF0aWMgaW50IHdmeF9zZGlvX2lycV9zdWJzY3Jp
YmUoc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1cykKIAkJCQkJICJ3ZngiLCBidXMpOwogfQogCi1z
dGF0aWMgaW50IHdmeF9zZGlvX2lycV91bnN1YnNjcmliZShzdHJ1Y3Qgd2Z4X3NkaW9fcHJpdiAq
YnVzKQorc3RhdGljIGludCB3Znhfc2Rpb19pcnFfdW5zdWJzY3JpYmUodm9pZCAqcHJpdikKIHsK
KwlzdHJ1Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzID0gcHJpdjsKIAlpbnQgcmV0OwogCiAJaWYgKGJ1
cy0+b2ZfaXJxKQpAQCAtMTU2LDYgKzE1OCw4IEBAIHN0YXRpYyBzaXplX3Qgd2Z4X3NkaW9fYWxp
Z25fc2l6ZSh2b2lkICpwcml2LCBzaXplX3Qgc2l6ZSkKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaHdi
dXNfb3BzIHdmeF9zZGlvX2h3YnVzX29wcyA9IHsKIAkuY29weV9mcm9tX2lvID0gd2Z4X3NkaW9f
Y29weV9mcm9tX2lvLAogCS5jb3B5X3RvX2lvID0gd2Z4X3NkaW9fY29weV90b19pbywKKwkuaXJx
X3N1YnNjcmliZSA9IHdmeF9zZGlvX2lycV9zdWJzY3JpYmUsCisJLmlycV91bnN1YnNjcmliZSA9
IHdmeF9zZGlvX2lycV91bnN1YnNjcmliZSwKIAkubG9jawkJCT0gd2Z4X3NkaW9fbG9jaywKIAku
dW5sb2NrCQkJPSB3Znhfc2Rpb191bmxvY2ssCiAJLmFsaWduX3NpemUJCT0gd2Z4X3NkaW9fYWxp
Z25fc2l6ZSwKQEAgLTIxMiwxOCArMjE2LDEyIEBAIHN0YXRpYyBpbnQgd2Z4X3NkaW9fcHJvYmUo
c3RydWN0IHNkaW9fZnVuYyAqZnVuYywKIAkJZ290byBlcnIxOwogCX0KIAotCXJldCA9IHdmeF9z
ZGlvX2lycV9zdWJzY3JpYmUoYnVzKTsKLQlpZiAocmV0KQotCQlnb3RvIGVycjE7Ci0KIAlyZXQg
PSB3ZnhfcHJvYmUoYnVzLT5jb3JlKTsKIAlpZiAocmV0KQotCQlnb3RvIGVycjI7CisJCWdvdG8g
ZXJyMTsKIAogCXJldHVybiAwOwogCi1lcnIyOgotCXdmeF9zZGlvX2lycV91bnN1YnNjcmliZShi
dXMpOwogZXJyMToKIAlzZGlvX2NsYWltX2hvc3QoZnVuYyk7CiAJc2Rpb19kaXNhYmxlX2Z1bmMo
ZnVuYyk7CkBAIC0yMzcsNyArMjM1LDYgQEAgc3RhdGljIHZvaWQgd2Z4X3NkaW9fcmVtb3ZlKHN0
cnVjdCBzZGlvX2Z1bmMgKmZ1bmMpCiAJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1cyA9IHNkaW9f
Z2V0X2RydmRhdGEoZnVuYyk7CiAKIAl3ZnhfcmVsZWFzZShidXMtPmNvcmUpOwotCXdmeF9zZGlv
X2lycV91bnN1YnNjcmliZShidXMpOwogCXNkaW9fY2xhaW1faG9zdChmdW5jKTsKIAlzZGlvX2Rp
c2FibGVfZnVuYyhmdW5jKTsKIAlzZGlvX3JlbGVhc2VfaG9zdChmdW5jKTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NwaS5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNf
c3BpLmMKaW5kZXggMDA2MTNkMDQ2YzNmLi5lOGRhNjFmYjA5NmIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvc3RhZ2luZy93ZngvYnVzX3NwaS5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3Nw
aS5jCkBAIC0xMiw2ICsxMiw3IEBACiAjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPgog
I2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4KICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4K
KyNpbmNsdWRlIDxsaW51eC9pcnEuaD4KICNpbmNsdWRlIDxsaW51eC9vZi5oPgogCiAjaW5jbHVk
ZSAiYnVzLmgiCkBAIC0xNDMsOCArMTQ0LDkgQEAgc3RhdGljIGlycXJldHVybl90IHdmeF9zcGlf
aXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqcHJpdikKIAlyZXR1cm4gSVJRX0hBTkRMRUQ7CiB9
CiAKLXN0YXRpYyBpbnQgd2Z4X3NwaV9pcnFfc3Vic2NyaWJlKHN0cnVjdCB3Znhfc3BpX3ByaXYg
KmJ1cykKK3N0YXRpYyBpbnQgd2Z4X3NwaV9pcnFfc3Vic2NyaWJlKHZvaWQgKnByaXYpCiB7CisJ
c3RydWN0IHdmeF9zcGlfcHJpdiAqYnVzID0gcHJpdjsKIAl1MzIgZmxhZ3M7CiAKIAlmbGFncyA9
IGlycV9nZXRfdHJpZ2dlcl90eXBlKGJ1cy0+ZnVuYy0+aXJxKTsKQEAgLTE1Niw2ICsxNTgsMTQg
QEAgc3RhdGljIGludCB3Znhfc3BpX2lycV9zdWJzY3JpYmUoc3RydWN0IHdmeF9zcGlfcHJpdiAq
YnVzKQogCQkJCQkgIndmeCIsIGJ1cyk7CiB9CiAKK3N0YXRpYyBpbnQgd2Z4X3NwaV9pcnFfdW5z
dWJzY3JpYmUodm9pZCAqcHJpdikKK3sKKwlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXMgPSBwcml2
OworCisJZGV2bV9mcmVlX2lycSgmYnVzLT5mdW5jLT5kZXYsIGJ1cy0+ZnVuYy0+aXJxLCBidXMp
OworCXJldHVybiAwOworfQorCiBzdGF0aWMgc2l6ZV90IHdmeF9zcGlfYWxpZ25fc2l6ZSh2b2lk
ICpwcml2LCBzaXplX3Qgc2l6ZSkKIHsKIAkvLyBNb3N0IG9mIFNQSSBjb250cm9sbGVycyBhdm9p
ZCBETUEgaWYgYnVmZmVyIHNpemUgaXMgbm90IDMyYml0IGFsaWduZWQKQEAgLTE2NSw2ICsxNzUs
OCBAQCBzdGF0aWMgc2l6ZV90IHdmeF9zcGlfYWxpZ25fc2l6ZSh2b2lkICpwcml2LCBzaXplX3Qg
c2l6ZSkKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaHdidXNfb3BzIHdmeF9zcGlfaHdidXNfb3BzID0g
ewogCS5jb3B5X2Zyb21faW8gPSB3Znhfc3BpX2NvcHlfZnJvbV9pbywKIAkuY29weV90b19pbyA9
IHdmeF9zcGlfY29weV90b19pbywKKwkuaXJxX3N1YnNjcmliZSA9IHdmeF9zcGlfaXJxX3N1YnNj
cmliZSwKKwkuaXJxX3Vuc3Vic2NyaWJlID0gd2Z4X3NwaV9pcnFfdW5zdWJzY3JpYmUsCiAJLmxv
Y2sJCQk9IHdmeF9zcGlfbG9jaywKIAkudW5sb2NrCQkJPSB3Znhfc3BpX3VubG9jaywKIAkuYWxp
Z25fc2l6ZQkJPSB3Znhfc3BpX2FsaWduX3NpemUsCkBAIC0yMTYsOCArMjI4LDYgQEAgc3RhdGlj
IGludCB3Znhfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpmdW5jKQogCWlmICghYnVzLT5j
b3JlKQogCQlyZXR1cm4gLUVJTzsKIAotCXdmeF9zcGlfaXJxX3N1YnNjcmliZShidXMpOwotCiAJ
cmV0dXJuIHdmeF9wcm9iZShidXMtPmNvcmUpOwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0
YWdpbmcvd2Z4L2hpZl90eC5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHguYwppbmRleCBl
OGYzYzVmOWNlN2IuLjUxMWVmODc0YTZkOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dm
eC9oaWZfdHguYworKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eC5jCkBAIC04Miw2ICs4
Miw5IEBAIGludCB3ZnhfY21kX3NlbmQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZf
bXNnICpyZXF1ZXN0LCB2b2lkICpyZXBseSwKIAlpZiAoYXN5bmMpCiAJCXJldHVybiAwOwogCisJ
aWYgKHdkZXYtPnBvbGxfaXJxKQorCQl3ZnhfYmhfcG9sbF9pcnEod2Rldik7CisKIAlyZXQgPSB3
YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJndkZXYtPmhpZl9jbWQuZG9uZSwgMSAqIEhaKTsK
IAlpZiAoIXJldCkgewogCQlkZXZfZXJyKHdkZXYtPmRldiwgImNoaXAgaXMgYWJub3JtYWxseSBs
b25nIHRvIGFuc3dlclxuIik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L21haW4u
YyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5jCmluZGV4IDVkMDc1NGI1NTQyOS4uNjIzYTlm
YzMxMTUzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L21haW4uYworKysgYi9kcml2
ZXJzL3N0YWdpbmcvd2Z4L21haW4uYwpAQCAtMzYzLDIyICszNjMsMjQgQEAgaW50IHdmeF9wcm9i
ZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldikKIAkvLyBwcmV2ZW50IGJoKCkgdG8gdG91Y2ggaXQuCiAJ
Z3Bpb19zYXZlZCA9IHdkZXYtPnBkYXRhLmdwaW9fd2FrZXVwOwogCXdkZXYtPnBkYXRhLmdwaW9f
d2FrZXVwID0gTlVMTDsKKwl3ZGV2LT5wb2xsX2lycSA9IHRydWU7CiAKIAl3ZnhfYmhfcmVnaXN0
ZXIod2Rldik7CiAKIAllcnIgPSB3ZnhfaW5pdF9kZXZpY2Uod2Rldik7CiAJaWYgKGVycikKLQkJ
Z290byBlcnIxOworCQlnb3RvIGVycjA7CiAKKwl3ZnhfYmhfcG9sbF9pcnEod2Rldik7CiAJZXJy
ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZ3ZGV2LT5maXJtd2FyZV9yZWFkeSwgMSAq
IEhaKTsKIAlpZiAoZXJyIDw9IDApIHsKIAkJaWYgKGVyciA9PSAwKSB7Ci0JCQlkZXZfZXJyKHdk
ZXYtPmRldiwgInRpbWVvdXQgd2hpbGUgd2FpdGluZyBmb3Igc3RhcnR1cCBpbmRpY2F0aW9uLiBJ
UlEgY29uZmlndXJhdGlvbiBlcnJvcj9cbiIpOworCQkJZGV2X2Vycih3ZGV2LT5kZXYsICJ0aW1l
b3V0IHdoaWxlIHdhaXRpbmcgZm9yIHN0YXJ0dXAgaW5kaWNhdGlvblxuIik7CiAJCQllcnIgPSAt
RVRJTUVET1VUOwogCQl9IGVsc2UgaWYgKGVyciA9PSAtRVJFU1RBUlRTWVMpIHsKIAkJCWRldl9p
bmZvKHdkZXYtPmRldiwgInByb2JlIGludGVycnVwdGVkIGJ5IHVzZXJcbiIpOwogCQl9Ci0JCWdv
dG8gZXJyMTsKKwkJZ290byBlcnIwOwogCX0KIAogCS8vIEZJWE1FOiBmaWxsIHdpcGh5Ojpod192
ZXJzaW9uCkBAIC00MDAsMTQgKzQwMiwxNCBAQCBpbnQgd2Z4X3Byb2JlKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2KQogCQkJInVuc3VwcG9ydGVkIGZpcm13YXJlIEFQSSB2ZXJzaW9uIChleHBlY3QgMSB3
aGlsZSBmaXJtd2FyZSByZXR1cm5zICVkKVxuIiwKIAkJCXdkZXYtPmh3X2NhcHMuYXBpX3ZlcnNp
b25fbWFqb3IpOwogCQllcnIgPSAtRU5PVFNVUFA7Ci0JCWdvdG8gZXJyMTsKKwkJZ290byBlcnIw
OwogCX0KIAogCWVyciA9IHdmeF9zbF9pbml0KHdkZXYpOwogCWlmIChlcnIgJiYgd2Rldi0+aHdf
Y2Fwcy5jYXBhYmlsaXRpZXMubGlua19tb2RlID09IFNFQ19MSU5LX0VORk9SQ0VEKSB7CiAJCWRl
dl9lcnIod2Rldi0+ZGV2LAogCQkJImNoaXAgcmVxdWlyZSBzZWN1cmVfbGluaywgYnV0IGNhbid0
IG5lZ29jaWF0ZSBpdFxuIik7Ci0JCWdvdG8gZXJyMTsKKwkJZ290byBlcnIwOwogCX0KIAogCWlm
ICh3ZGV2LT5od19jYXBzLnJlZ3VsX3NlbF9tb2RlX2luZm8ucmVnaW9uX3NlbF9tb2RlKSB7CkBA
IC00MjAsNyArNDIyLDE2IEBAIGludCB3ZnhfcHJvYmUoc3RydWN0IHdmeF9kZXYgKndkZXYpCiAJ
CXdkZXYtPnBkYXRhLmZpbGVfcGRzKTsKIAllcnIgPSB3Znhfc2VuZF9wZGF0YV9wZHMod2Rldik7
CiAJaWYgKGVyciA8IDApCi0JCWdvdG8gZXJyMTsKKwkJZ290byBlcnIwOworCisJd2Rldi0+cG9s
bF9pcnEgPSBmYWxzZTsKKwllcnIgPSB3ZGV2LT5od2J1c19vcHMtPmlycV9zdWJzY3JpYmUod2Rl
di0+aHdidXNfcHJpdik7CisJaWYgKGVycikKKwkJZ290byBlcnIwOworCisJZXJyID0gaGlmX3Vz
ZV9tdWx0aV90eF9jb25mKHdkZXYsIHRydWUpOworCWlmIChlcnIpCisJCWRldl9lcnIod2Rldi0+
ZGV2LCAibWlzY29uZmlndXJlZCBJUlE/XG4iKTsKIAogCXdkZXYtPnBkYXRhLmdwaW9fd2FrZXVw
ID0gZ3Bpb19zYXZlZDsKIAlpZiAod2Rldi0+cGRhdGEuZ3Bpb193YWtldXApIHsKQEAgLTQzNSw4
ICs0NDYsNiBAQCBpbnQgd2Z4X3Byb2JlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQogCQloaWZfc2V0
X29wZXJhdGlvbmFsX21vZGUod2RldiwgSElGX09QX1BPV0VSX01PREVfRE9aRSk7CiAJfQogCi0J
aGlmX3VzZV9tdWx0aV90eF9jb25mKHdkZXYsIHRydWUpOwotCiAJZm9yIChpID0gMDsgaSA8IEFS
UkFZX1NJWkUod2Rldi0+YWRkcmVzc2VzKTsgaSsrKSB7CiAJCWV0aF96ZXJvX2FkZHIod2Rldi0+
YWRkcmVzc2VzW2ldLmFkZHIpOwogCQltYWNhZGRyID0gb2ZfZ2V0X21hY19hZGRyZXNzKHdkZXYt
PmRldi0+b2Zfbm9kZSk7CkBAIC00NzAsNiArNDc5LDggQEAgaW50IHdmeF9wcm9iZShzdHJ1Y3Qg
d2Z4X2RldiAqd2RldikKIGVycjI6CiAJaWVlZTgwMjExX3VucmVnaXN0ZXJfaHcod2Rldi0+aHcp
OwogZXJyMToKKwl3ZGV2LT5od2J1c19vcHMtPmlycV91bnN1YnNjcmliZSh3ZGV2LT5od2J1c19w
cml2KTsKK2VycjA6CiAJd2Z4X2JoX3VucmVnaXN0ZXIod2Rldik7CiAJcmV0dXJuIGVycjsKIH0K
QEAgLTQ3OCw2ICs0ODksNyBAQCB2b2lkIHdmeF9yZWxlYXNlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
KQogewogCWllZWU4MDIxMV91bnJlZ2lzdGVyX2h3KHdkZXYtPmh3KTsKIAloaWZfc2h1dGRvd24o
d2Rldik7CisJd2Rldi0+aHdidXNfb3BzLT5pcnFfdW5zdWJzY3JpYmUod2Rldi0+aHdidXNfcHJp
dik7CiAJd2Z4X2JoX3VucmVnaXN0ZXIod2Rldik7CiAJd2Z4X3NsX2RlaW5pdCh3ZGV2KTsKIH0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93Zngvd2Z4LmggYi9kcml2ZXJzL3N0YWdpbmcv
d2Z4L3dmeC5oCmluZGV4IDA5YmJiNWRhNGYwNi4uNGViNzc2MjE0MmZjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93Zngvd2Z4LmgK
QEAgLTQ2LDYgKzQ2LDcgQEAgc3RydWN0IHdmeF9kZXYgewogCXN0cnVjdCB3ZnhfaGlmCQloaWY7
CiAJc3RydWN0IHNsX2NvbnRleHQJc2w7CiAJc3RydWN0IGRlbGF5ZWRfd29yawljb29saW5nX3Rp
bWVvdXRfd29yazsKKwlib29sCQkJcG9sbF9pcnE7CiAJYm9vbAkJCWNoaXBfZnJvemVuOwogCXN0
cnVjdCBtdXRleAkJY29uZl9tdXRleDsKIAotLSAKMi4yNi4xCgo=
