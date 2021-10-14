Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12D42DB9A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Oct 2021 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhJNOdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 10:33:05 -0400
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:13281
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231822AbhJNOdD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 10:33:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdtIS+EB/Edm9oWpLUXeHL23zkKHsAj+tq3lrYIf4hzKqOCe93Tp4ILj7NqMWrQeL0AJESL6ovutucOd9bvsrtR+Um+CIQ1ossE2MfjrwaT9QzBh+bdTd0a7nvZvhpJDaVcN4+cbBZwYau4HR7gUsoLTb9dUx1u/JndufQdF1sokoqUCs7bk0lGW/IqgfYWS+4OZy1wPToKkDAs9Yu7GO+6bi0S5Vj/ST0MftwrDeUX7ljyN1lhu+Eo24unfTmzskrJfxZp2FGwYFeZB5FoqPq7lVTUVu6x0UYXY4EsEXb/bOwWuB59zt3DCowjVS98ma9MXyRZ6q2iKxruVIuSEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk1JgEHAcQHubNtfRRkcleaHDt09SGba+15Hd9l57yg=;
 b=HuGKWDRM/SK72aQ3jJeHOuhu9x9Yilr1ESqPmp4ts2q0t7irXHMe8VE6Rx7ysNcRHSy2N85x+bK0i6UztIkw0j0A9CF0FLmfYthBe3BfRBuPZD9DCa0kVOadcnpeAgJt2hfgllyfT91eNEOxGFxX5e+Ib+uzB6Isfo7uafpaXtsubGJVba7cThsVgvAPpJENf2R8qTsa7IpyBZdJwnHQi+4AFSF+xez4E25+FdmiuoIDyMCHnoSkRE9NQn2qwN0y1f7nVVySQUoDvn8TLiGJS4ktHBZRBVdXKSMKS2WghXaLqxhf/jHhgxZmBFepkNbTNPZ8jCB3imzkNFk5yfVVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk1JgEHAcQHubNtfRRkcleaHDt09SGba+15Hd9l57yg=;
 b=CrnnS9bBy4myWYrj7Y/yxT1b/KTWysj1CsAD7okaDacUmLrfm4HV9pPE87dG2oemU5AIAAju73ZOrCJSM54/tMYXf72kBA8z7N5Q44wIjMUyaAIVthY8NlgWRWXEjD1Fa0dd8smbXBh0U2IxvQjpTdzBB0gQ/nEmX6lCKekl2n8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 14 Oct
 2021 14:30:54 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4%9]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 14:30:54 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [RFC PATCH 1/2] mmc: rewrite mmc_fixup_device()
Date:   Thu, 14 Oct 2021 16:30:30 +0200
Message-Id: <20211014143031.1313783-2-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014143031.1313783-1-Jerome.Pouiller@silabs.com>
References: <20211014143031.1313783-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::20) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 14:30:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16c88a5-dd1b-4dfd-9a3f-08d98f1f3aa1
X-MS-TrafficTypeDiagnostic: PH0PR11MB5643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB56431F3CB74069984E7116C593B89@PH0PR11MB5643.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdoUgd9tarnmP79aKPuNdlh/BZPjGKqSrrS1aPxMxvcBNE+3BjywGSDfrbHimoXxYzqgTnZGSVsEfcpjjGu7h+TcWjIc1ewiW9d0vrlyQEbENI4aGLE7ARpSmwSplkADU+gL/ZpzasYmS+KZT7lsAxnrrXwm0lH383lkqBzJCxh4mOu97xOhicHYy2rAqaZ6hAsRtxf9BbnZFWAOAU6+oc3vHOE2mlxg6jGJ7rApaRVZW7g/haOIlNx1HTCFggBwnBHUA47TD7VLP6ijHY1Cad24AtOSom76Ws3UAGOaZvEexMKyJ+oTu+W7Aa2tuNKWw90SIfzDM9FI6Ulq6xPDDGWeG2F/0AvG0oq1l9YljgXgqyHV9rV/OefEvMFO7nPNIvc4PaJpEgZkCjmak0qnubJTQzkcKvYuN7Bc2nAvVuVJUBIDox8lG/7UbFNgFGZoJcxoJav+rKx8X7sUPeZddOMQVVTFwC1mpPs7PaLkScnXjb0BID/eB13alLo1GF/cw0XmYCZ1qDITfevqUiy/H484/f7lcocFq/8K8/KcqWMIXXBtPShTm7JlN5jXVYzIrdm9CYKZeYQQzBwJhLM291tW9CAoJOU6ISXljeU/RcLjLrOzCVoY4ge+1+3qv/9Pd3tFf8eYqf2F4qqAi/8o4AQKt0HuSlXQTvK0FrlnD7X/JlG3bOMxcjeypSYIoDLtz9L0vvHWHPemNPiQ7YsKyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(38350700002)(7696005)(508600001)(186003)(8676002)(316002)(956004)(38100700002)(6916009)(54906003)(66476007)(2906002)(6666004)(86362001)(36756003)(107886003)(8936002)(4326008)(26005)(66946007)(83380400001)(1076003)(2616005)(66556008)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNOQlZJZHN5OGZlbEEwU2d3RXh3Y3hNcXpyUzVWLytqeXBqcHJpMm52NWFq?=
 =?utf-8?B?VEx1ZlJjazdRZEVzYlF0RVhidlJCbzR5MGlhOCt4cnV1QVFzVWY4MGhDYUV2?=
 =?utf-8?B?N3lyNGx4TnhidUZGczljcDVZKzRwSlU5TCtZeCswREpGVmxGRDhGTmRhaVlk?=
 =?utf-8?B?S3B6Sjk4OExsSGJIWHFHMVhSWkRNeGh1bkRpdFROaURQcEt1cjRRY2JQMElQ?=
 =?utf-8?B?bU9zZ2VlRDBhNEIxbjBXZ2JUOW1VRkhpL29kL0tiYndGb1d0dXRpQyt5OG9Q?=
 =?utf-8?B?UFlUcnVPSGFPcmZkMTZFeHlrRDRNRW1ZYm9hWk93T3NpMHFlUVZKMkptNjVY?=
 =?utf-8?B?cm5ZOFhlckpwWnZJMjRoTndpN3F0UUFCSFM4MFV0QVdFdHF5SzRBUjVDNjJI?=
 =?utf-8?B?dnl6U2RlNFV5ak8rTU0xYnpmRzNPK09VR0gyRHdTbWVTUmQwZ2xoNERYZmVW?=
 =?utf-8?B?RU4wcWc5UUs3YlV0WXhUaTRvZWo0M0Zidm1KdFluS0EwM2NpMEZXdEpvYTJ5?=
 =?utf-8?B?UncvdEN2QUNpRWYwM1VQOCt6dVRSbVAxdkxoR3gvaEhXWk1YY0JmYTRGUGZV?=
 =?utf-8?B?VkFhZ25CZE92VjhVSmpBdmVTaE5OK0c3VkZuUytQNEQ0OEl3SnRXWkg4M3k0?=
 =?utf-8?B?VEhCd3g4clorUXUrUjJISkh2alFEWW83bDNHRXVpYjNjd1M2T2tCRjRod1l2?=
 =?utf-8?B?UzJrMGs1RVhzSmxjcHgyczFXcEM5YTR5K2lwL1JuR2lGbzdUdDVVRitxZzRv?=
 =?utf-8?B?cHhSK0FCcVc5bHRRKzdld1pwWG9TL3VTQzl6NTU1TEhFSjNVR2p2anlWWjJl?=
 =?utf-8?B?Rlp6eTZ2R1dDQ1N1OWIyRzR4MGVMdzI5MGNTYmxKb0o5L0l6T29waEtrSU01?=
 =?utf-8?B?S1lDY0xjZmlnWWNtNjdBeTZjdmRFOGRsb0hwcHBWeUxLTUN3Sm5QY0xGMEZP?=
 =?utf-8?B?TTlpZVRXNCtNRnFmVk54S0JBaC80NVZqUVB3ZktmRDZ4cmtqZEY1d0R0QWR0?=
 =?utf-8?B?VDEwbnBKTWZMYW5henZjdHhSbmJvUVl5TlFqekY3Y2lueUl3bHhqbVVvZlFX?=
 =?utf-8?B?Mi9GMzE4ZUpiWlFuSURMTHRGdGpVWFdxc0hCVmVsYlNCWXlSUFFpTjVIdVN3?=
 =?utf-8?B?N3RGdW9rU0JHbU9qRitJbGE2bjUzcEVDNlBicHZUNzh5YTlFbXNFNnRKaDN6?=
 =?utf-8?B?R3kxWVpMdm1oM1B0ZlZvWUlNTlRoZTJsQU12Z3hzT2E5WUI1a1FrbE94RS84?=
 =?utf-8?B?MTArbW5WUGxSbmxuR2JjWDhtZmNXSXk1TVQ1cTFSK2d6VkU2SGVsdjJTQm1y?=
 =?utf-8?B?VVV6OG1vVkp1NVVFNUJxVmVOZVNIS1UwNWw1YzlKVUZxZDFvS1JMKzRHa1Yv?=
 =?utf-8?B?cStNRlAvL1JOblFOUUFIOXhheUo5TUhYWDc4dmN0dGlySzVuTVNGTjJwQ3ZR?=
 =?utf-8?B?UzRSUFJnc2RrWGtLRFV3VEo0Z0txVDZYNjdrK3RMSlg2REJubzJET1owMXVj?=
 =?utf-8?B?aVFKSExnT2hWdlprNnZvUlZkNzN6MjJWQXlEZ3NXdlpDTmRwVXk2VStNSmJn?=
 =?utf-8?B?ZVJlZ2x1bCtTVUNQSEpJQS9DTU9ORFV3RzNpTmEyd0kwYUtKUzRJQmNSTmxL?=
 =?utf-8?B?c0NGZUJldHhPZ2FGQ2ppT3RQQlJ5ZzJkRE5CYi90dk9VSDZIVXhIdEZ5dGoy?=
 =?utf-8?B?Z1M5SmQ0TVJhWjZQa0U1WWk3ZWxyTGQ0YmRCUmNYa0Z1cEk2eTZnVDkxOExk?=
 =?utf-8?Q?+DlH0Z3TYUNyYz98e/YJ5d8Sj1TMN+kPou30Kqk?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16c88a5-dd1b-4dfd-9a3f-08d98f1f3aa1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 14:30:54.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WXOoEAAzcgulNmR12oO8A6aOkWINWvt1Pg5gTRYnpgp3gq8pZzz0+ihw5jh54AMJo8+OkVqC48i7T6QMNcMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5643
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKQ3Vy
cmVudGx5LCBtbWNfZml4dXBfZGV2aWNlKCkgaXMgYSBiaXQgZGlmZmljdWx0IHRvIHJlYWQgYmVj
YXVzZSBvZgpwYXJ0aWN1bGFybHkgbG9uZyBjb25kaXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBKw6ly
w7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVycy9t
bWMvY29yZS9xdWlya3MuaCB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmggYi9kcml2ZXJzL21tYy9jb3Jl
L3F1aXJrcy5oCmluZGV4IGQ2OGU2ZTUxM2E0Zi4uYzdlZjJkMTRiMzU5IDEwMDY0NAotLS0gYS9k
cml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgK
QEAgLTE1MiwyMiArMTUyLDI5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtbWNfZml4dXBfZGV2aWNl
KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwKIAl1NjQgcmV2ID0gY2lkX3Jldl9jYXJkKGNhcmQpOwog
CiAJZm9yIChmID0gdGFibGU7IGYtPnZlbmRvcl9maXh1cDsgZisrKSB7Ci0JCWlmICgoZi0+bWFu
ZmlkID09IENJRF9NQU5GSURfQU5ZIHx8Ci0JCSAgICAgZi0+bWFuZmlkID09IGNhcmQtPmNpZC5t
YW5maWQpICYmCi0JCSAgICAoZi0+b2VtaWQgPT0gQ0lEX09FTUlEX0FOWSB8fAotCQkgICAgIGYt
Pm9lbWlkID09IGNhcmQtPmNpZC5vZW1pZCkgJiYKLQkJICAgIChmLT5uYW1lID09IENJRF9OQU1F
X0FOWSB8fAotCQkgICAgICFzdHJuY21wKGYtPm5hbWUsIGNhcmQtPmNpZC5wcm9kX25hbWUsCi0J
CQkgICAgICBzaXplb2YoY2FyZC0+Y2lkLnByb2RfbmFtZSkpKSAmJgotCQkgICAgKGYtPmNpc192
ZW5kb3IgPT0gY2FyZC0+Y2lzLnZlbmRvciB8fAotCQkgICAgIGYtPmNpc192ZW5kb3IgPT0gKHUx
NikgU0RJT19BTllfSUQpICYmCi0JCSAgICAoZi0+Y2lzX2RldmljZSA9PSBjYXJkLT5jaXMuZGV2
aWNlIHx8Ci0JCSAgICAgZi0+Y2lzX2RldmljZSA9PSAodTE2KSBTRElPX0FOWV9JRCkgJiYKLQkJ
ICAgIChmLT5leHRfY3NkX3JldiA9PSBFWFRfQ1NEX1JFVl9BTlkgfHwKLQkJICAgICBmLT5leHRf
Y3NkX3JldiA9PSBjYXJkLT5leHRfY3NkLnJldikgJiYKLQkJICAgIHJldiA+PSBmLT5yZXZfc3Rh
cnQgJiYgcmV2IDw9IGYtPnJldl9lbmQpIHsKLQkJCWRldl9kYmcoJmNhcmQtPmRldiwgImNhbGxp
bmcgJXBzXG4iLCBmLT52ZW5kb3JfZml4dXApOwotCQkJZi0+dmVuZG9yX2ZpeHVwKGNhcmQsIGYt
PmRhdGEpOwotCQl9CisJCWlmIChmLT5tYW5maWQgIT0gQ0lEX01BTkZJRF9BTlkgJiYKKwkJICAg
IGYtPm1hbmZpZCAhPSBjYXJkLT5jaWQubWFuZmlkKQorCQkJY29udGludWU7CisJCWlmIChmLT5v
ZW1pZCAhPSBDSURfT0VNSURfQU5ZICYmCisJCSAgICBmLT5vZW1pZCAhPSBjYXJkLT5jaWQub2Vt
aWQpCisJCQljb250aW51ZTsKKwkJaWYgKGYtPm5hbWUgIT0gQ0lEX05BTUVfQU5ZICYmCisJCSAg
ICBzdHJuY21wKGYtPm5hbWUsIGNhcmQtPmNpZC5wcm9kX25hbWUsCisJCQkgICAgc2l6ZW9mKGNh
cmQtPmNpZC5wcm9kX25hbWUpKSkKKwkJCWNvbnRpbnVlOworCQlpZiAoZi0+Y2lzX3ZlbmRvciAh
PSAodTE2KVNESU9fQU5ZX0lEICYmCisJCSAgICBmLT5jaXNfdmVuZG9yICE9IGNhcmQtPmNpcy52
ZW5kb3IpCisJCQljb250aW51ZTsKKwkJaWYgKGYtPmNpc19kZXZpY2UgIT0gKHUxNilTRElPX0FO
WV9JRCAmJgorCQkgICAgZi0+Y2lzX2RldmljZSAhPSBjYXJkLT5jaXMuZGV2aWNlKQorCQkJY29u
dGludWU7CisJCWlmIChmLT5leHRfY3NkX3JldiAhPSBFWFRfQ1NEX1JFVl9BTlkgJiYKKwkJICAg
IGYtPmV4dF9jc2RfcmV2ICE9IGNhcmQtPmV4dF9jc2QucmV2KQorCQkJY29udGludWU7CisJCWlm
IChyZXYgPCBmLT5yZXZfc3RhcnQgfHwgcmV2ID4gZi0+cmV2X2VuZCkKKwkJCWNvbnRpbnVlOwor
CisJCWRldl9kYmcoJmNhcmQtPmRldiwgImNhbGxpbmcgJXBzXG4iLCBmLT52ZW5kb3JfZml4dXAp
OworCQlmLT52ZW5kb3JfZml4dXAoY2FyZCwgZi0+ZGF0YSk7CiAJfQogfQotLSAKMi4zMy4wCgo=
