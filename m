Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFA3200305
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2020 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgFSHyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jun 2020 03:54:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8441 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730880AbgFSHyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jun 2020 03:54:38 -0400
X-UUID: 6f1163112088486c9cd2fc5b0c68a6d0-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3ltb5nZixCRRCc99x3WnmbZJW+adF+mROtOvKeMYdTU=;
        b=VKazcRPZ0f41QhAF97CcS9nhFUfAktB8DoW9iLxUxJ9RtEmKi6D5PX6pO78/Wrm1/MbjKWIiXCDDQP+c5YmfjVlUZEvQQUmqevS6Z5PgEnXyjGL9buGGfvwvyCZDQPzV9tIqQWM+Z1J51bFNVYBfL2HQ83kOirkK1cATWdFWQNQ=;
X-UUID: 6f1163112088486c9cd2fc5b0c68a6d0-20200619
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1039615397; Fri, 19 Jun 2020 15:54:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 15:54:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 15:54:33 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 1/3] mt76: mt7915: add support for DT rate power limits
Date:   Fri, 19 Jun 2020 15:53:54 +0800
Message-ID: <20200619075356.21998-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 93753E75486CD0CC19EF944C029F540EC5AF6B68F7BACB2C1D540A680174057C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RW5hYmxlIHRvIGxpbWl0IHBlci1yYXRlIG1heCB0eHBvd2VyIGZyb20gRFQuDQoNClRlc3RlZC1i
eTogRXZlbHluIFRzYWkgPGV2ZWx5bi50c2FpQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6
IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCnYyOg0KIC0gc3Vi
dHJhY3QgbnNzX2RlbHRhIGZyb20gdHhwb3dlcl9jdXIgDQogLSBzZXQgdHhwb3dlcl9jdXIgdG8g
dGhlIHJldHVybiBjb2RlIG9mIG10NzZfZ2V0X3JhdGVfcG93ZXJfbGltaXRzDQoNClRoZSBzZXJp
ZXMgaXMgYmFzZWQgb24gRmVsaXgncyBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvbGludXgtd2lyZWxlc3MvbGlzdC8/c2VyaWVzPTMwMzkxMw0KLS0tDQogLi4uL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYyAgIHwgNDQgKysrKysrKysrKysrKysrKy0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KaW5k
ZXggYzhjMTJjNy4uMTA3ODc3MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tY3UuYw0KQEAgLTMwNjgsMTUgKzMwNjgsNDcgQEAgaW50IG10Nzkx
NV9tY3Vfc2V0X3NrdShzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0KIAkJLmZvcm1hdF9pZCA9IDQs
DQogCQkuZGJkY19pZHggPSBwaHkgIT0gJmRldi0+cGh5LA0KIAl9Ow0KLQlpbnQgaTsNCi0Jczgg
KmRlbHRhOw0KKwlzdHJ1Y3QgbXQ3Nl9wb3dlcl9saW1pdHMgbGltaXRzX2FycmF5Ow0KKwlzOCAq
ZGVsdGEsICpsYSA9IChzOCAqKSZsaW1pdHNfYXJyYXk7DQorCWludCBpLCBpZHgsIG5fY2hhaW5z
ID0gaHdlaWdodDgobXBoeS0+YW50ZW5uYV9tYXNrKTsNCisJaW50IHR4X3Bvd2VyOw0KIA0KIAlk
ZWx0YSA9IGRldi0+cmF0ZV9wb3dlclttcGh5LT5jaGFuZGVmLmNoYW4tPmJhbmRdOw0KLQltcGh5
LT50eHBvd2VyX2N1ciA9IGh3LT5jb25mLnBvd2VyX2xldmVsICogMiArDQotCQkJICAgIGRlbHRh
W01UNzkxNV9TS1VfTUFYX0RFTFRBX0lEWF07DQorCXR4X3Bvd2VyID0gaHctPmNvbmYucG93ZXJf
bGV2ZWwgKiAyIC0NCisJCSAgIG10NzZfdHhfcG93ZXJfbnNzX2RlbHRhKG5fY2hhaW5zKTsNCiAN
Ci0JZm9yIChpID0gMDsgaSA8IE1UNzkxNV9TS1VfUkFURV9OVU07IGkrKykNCi0JCXJlcS52YWxb
aV0gPSBody0+Y29uZi5wb3dlcl9sZXZlbCAqIDIgKyBkZWx0YVtpXTsNCisJdHhfcG93ZXIgPSBt
dDc2X2dldF9yYXRlX3Bvd2VyX2xpbWl0cyhtcGh5LCBtcGh5LT5jaGFuZGVmLmNoYW4sDQorCQkJ
CQkgICAgICAmbGltaXRzX2FycmF5LCB0eF9wb3dlcik7DQorCW1waHktPnR4cG93ZXJfY3VyID0g
dHhfcG93ZXI7DQorDQorCWZvciAoaSA9IDAsIGlkeCA9IDA7IGkgPCBBUlJBWV9TSVpFKG10Nzkx
NV9za3VfZ3JvdXBzKTsgaSsrKSB7DQorCQljb25zdCBzdHJ1Y3Qgc2t1X2dyb3VwICpza3UgPSAm
bXQ3OTE1X3NrdV9ncm91cHNbaV07DQorCQl1MzIgb2Zmc2V0ID0gc2t1LT5vZmZzZXRbbXBoeS0+
Y2hhbmRlZi5jaGFuLT5iYW5kXTsNCisJCXU4IG1jc19udW0gPSBza3UtPmxlbjsNCisJCWludCBq
Ow0KKw0KKwkJaWYgKGkgPj0gU0tVX0hUX0JXMjAgJiYgaSA8PSBTS1VfVkhUX0JXMTYwKSB7DQor
CQkJbWNzX251bSA9IDEwOw0KKw0KKwkJCWlmIChpID09IFNLVV9IVF9CVzIwIHx8IGkgPT0gU0tV
X1ZIVF9CVzIwKQ0KKwkJCQlsYSA9IChzOCAqKSZsaW1pdHNfYXJyYXkgKyAxMjsNCisJCX0NCisN
CisJCWlmICghb2Zmc2V0KSB7DQorCQkJaWR4ICs9IHNrdS0+bGVuOw0KKwkJCWxhICs9IG1jc19u
dW07DQorCQkJY29udGludWU7DQorCQl9DQorDQorCQlmb3IgKGogPSAwOyBqIDwgbWluX3QodTgs
IG1jc19udW0sIHNrdS0+bGVuKTsgaisrKSB7DQorCQkJczggcmF0ZV9wb3dlcjsNCisNCisJCQly
YXRlX3Bvd2VyID0gaHctPmNvbmYucG93ZXJfbGV2ZWwgKiAyICsgZGVsdGFbaWR4ICsgal07DQor
CQkJcmVxLnZhbFtpZHggKyBqXSA9IG1pbl90KHM4LCBsYVtqXSwgcmF0ZV9wb3dlcik7DQorCQl9
DQorCQlsYSArPSBtY3NfbnVtOw0KKwkJaWR4ICs9IHNrdS0+bGVuOw0KKwl9DQogDQogCXJldHVy
biBfX210NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsDQogCQkJCSAgIE1DVV9FWFRfQ01EX1RY
X1BPV0VSX0ZFQVRVUkVfQ1RSTCwNCi0tIA0KMi4xNy4xDQo=

