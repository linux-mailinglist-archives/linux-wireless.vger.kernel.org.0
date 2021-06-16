Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828693AA6C1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhFPWsM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Jun 2021 18:48:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60121 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233244AbhFPWsL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Jun 2021 18:48:11 -0400
X-UUID: 95d26d7d3900404e9a67d5d1228521fb-20210617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BIGTRtMI1M/NxPYpKDB7DZogZmTNQfskBsrd2oYAmuk=;
        b=L8srGFrXGuPK5n3XRPEUg8YYkelnPCS0oEHOj54aqNumAu+AUVDCE902Q/yEG+rsK98inaM5j5hJoEHyuo3msUZWHccXBaXRycgzp+3vuUZOXpuPW9wTXITvxvLp+yfSIHsuRjRoeGKl1iaOzqczoDJhxhRJBZPMPdq4FJo6fV4=;
X-UUID: 95d26d7d3900404e9a67d5d1228521fb-20210617
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2097622048; Thu, 17 Jun 2021 06:45:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:45:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:45:58 +0800
Message-ID: <1623883558.21078.1.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/4] mac80211: call ieee80211_tx_h_rate_ctrl() when
 dequeue
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 17 Jun 2021 06:45:58 +0800
In-Reply-To: <527da6e8-172d-95ad-9a28-a790b19fa945@nbd.name>
References: <2176023d8f13d82d093452e1c105609396c30622.1622164961.git.ryder.lee@mediatek.com>
         <527da6e8-172d-95ad-9a28-a790b19fa945@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTEwIGF0IDEzOjEwICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAyMDIxLTA1LTI4IDA4OjA1LCBSeWRlciBMZWUgd3JvdGU6DQo+ID4gTWFrZSBpZWVlODAy
MTFfdHhfaF9yYXRlX2N0cmwoKSBnZXQgY2FsbGVkIG9uIGRlcXVldWUgdG8gaW1wcm92ZQ0KPiA+
IHBlcmZvcm1hbmNlIHNpbmNlIGl0IHJlZHVjZXMgdGhlIHR1cm5hcm91bmQgdGltZSBmb3IgcmF0
ZSBjb250cm9sLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVl
QG1lZGlhdGVrLmNvbT4NCj4gRm9yIHRoZSBtYWM4MDIxMSBwYXRjaGVzOg0KPiBBY2tlZC1ieTog
RmVsaXggRmlldGthdSA8bmJkQG5iZC5uYW1lPg0KDQpIaSBKb2hhbm5lcywNCg0KRG9lcyB0aGlz
IHNlcmllcyBsb29rIG9rYXkgdG8geW91Pw0KDQpSeWRlcg0K

