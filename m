Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8268C1F9E32
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgFORNQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 13:13:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33623 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728585AbgFORNQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 13:13:16 -0400
X-UUID: df1bfc7232ba4cc7bab4fcfdee85d616-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oc3QafXm1CF82YjlI6nqdyTBr7TSVE8fsidMZ+Pjrj4=;
        b=pIaFWFzk5JV22FVKNyeQsj08lUvQ54tf+yAbR2QQ3TBs8/WASXDuBuuBuOqKN9psIb14sJiwieb4Xy2L93AzXvCAxVbT54jb8wKRAI2x6/UXix18N0VxV6xJdbMLaltHc1g1CH58yZz37AnbAS2FgjJVpCgrK6/5skJzgnx9CPk=;
X-UUID: df1bfc7232ba4cc7bab4fcfdee85d616-20200616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2512114; Tue, 16 Jun 2020 01:13:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 01:13:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 01:13:06 +0800
Message-ID: <1592241189.9611.2.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/4] mt76: mt7915: add missing CONFIG_MAC80211_DEBUGFS
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>
Date:   Tue, 16 Jun 2020 01:13:09 +0800
In-Reply-To: <87sgewe34z.fsf@tynnyri.adurom.net>
References: <cover.1592158312.git.ryder.lee@mediatek.com>
         <2863c9a7e14c791202738597184f4a6b75d5bc07.1592158312.git.ryder.lee@mediatek.com>
         <87sgewe34z.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 07440FB9B681473D20C4BC95386B2CA7ADBFE4D833AB41BCEA6F6123F4DCF7792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTE1IGF0IDE4OjU0ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gQWRkIENP
TkZJR19NQUM4MDIxMV9ERUJVR0ZTIHRvIGZpeCBhIHJlcG9ydGVkIHdhcm5pbmcuDQo+ID4NCj4g
PiBGaXhlczogZWM5NzQyYSAoIm10NzY6IG10NzkxNTogYWRkIC5zdGFfYWRkX2RlYnVnZnMgc3Vw
cG9ydCIpDQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4N
Cj4gDQo+IFNhbWUgY29tbWVudHMgYXMgaW4gdjI6DQo+IA0KPiBGaXhlczogZWM5NzQyYThmMzhl
ICgibXQ3NjogbXQ3OTE1OiBhZGQgLnN0YV9hZGRfZGVidWdmcyBzdXBwb3J0IikNCj4gDQo+IFNo
b3VsZCB0aGlzIGdvIHRvIHY1Ljg/DQo+IA0KDQpZZXA6KQ0KDQpSeWRlcg0K

