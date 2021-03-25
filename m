Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1B349D09
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 00:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCYXvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 19:51:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55682 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231445AbhCYXvH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 19:51:07 -0400
X-UUID: e25702d8a206443d82adc706dcd0e00e-20210326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=A+r3ZCIBQxVHt9voIgiPko8MotKHzte07lmFGpXmOlI=;
        b=ZID52VX0qU5jj8A74t8aIwwlP2VR22gtfIipC+dZSSeghQxl2ZPSVX9X+Psz5sFPLfDOKpmC31+vEH1nBwFb3e8NMH8HdQNLJsabPjluirHfuDiVurNBcYoUTXMPbT005mHQnA86guOpB7+cAwi4rOgaGi3igw3eYwke9sX5z7k=;
X-UUID: e25702d8a206443d82adc706dcd0e00e-20210326
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 753296988; Fri, 26 Mar 2021 07:51:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Mar 2021 07:51:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Mar 2021 07:51:00 +0800
Message-ID: <1616716260.5392.4.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] mt76: mt7615: cleanup mcu tx queue in
 mt7615_dma_reset()
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 26 Mar 2021 07:51:00 +0800
In-Reply-To: <750b96aa-f26a-5c2a-7040-4bb84a7aa6a7@nbd.name>
References: <fdde0eb8c6dea0e81b5f5ae528085f1ccf53fef3.1616696376.git.ryder.lee@mediatek.com>
         <750b96aa-f26a-5c2a-7040-4bb84a7aa6a7@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IE9uIDIwMjEtMDMtMjUgMTk6MjgsIFJ5ZGVyIExlZSB3cm90ZToNCj4gPiBDbGVhbnVwIGV4
dF9waHkgYW5kIG1jdSB0eCBxdWV1ZSBzbyB0aGF0IG10NzYxNV9tYWNfcmVzZXRfd29yaygpIGNh
bg0KPiA+IHJlY292ZXIgbXQ3NjE1IG5vcm1hbGx5Lg0KPiA+IA0KPiA+IEZpeGVzOiBtdDc2OiBl
NjM3NzYzYjYwNiAoIm1vdmUgbWN1IHF1ZXVlcyB0byBtdDc2X2RldiBxX21jdSBhcnJheSIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+IGNoYW5nZSBzaW5jZSB2MiAtIGNsZWFudXAgbXBoeV9leHQtPnFfdHgNCj4gSSBs
aWtlIHYxIGJldHRlciwgc2luY2UgZXh0LXBoeSB0eCBxdWV1ZXMgYXJlIHRoZSBzYW1lIGFzIHBy
aW1hcnkgcGh5IHR4DQo+IHF1ZXVlcy4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4gDQo+
IC0gRmVsaXgNCnJpZ2h0LiBpIGRpZG4ndCBub3RpY2UgbXQ3NjE1IGV4dC1waHkgc2hhcmVzIHRo
ZSBzYW1lIHR4IHF1ZXVlcyB3aXRoDQpwcmltYXJ5IHBoeS4gcGxlYXNlIGRyb3AgdGhpcyBvbmUu
DQo=

