Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A591FAB3A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 10:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgFPIa6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 04:30:58 -0400
Received: from mail.aperture-lab.de ([138.201.29.205]:39676 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFPIa5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 04:30:57 -0400
Date:   Tue, 16 Jun 2020 10:30:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1592296250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=daY7OUPEfb5CKo/Pydvmc0kyGEOmV/XDwnAbEgqBeqg=;
        b=AyWs74zzD/pXLscKR94Bjvt4tQ54XwDfSRMpj2U0yRtVW/w/G2lzk4xZ02mftqqNIs/HdC
        TcPHYKFj/TKS5m6ug5m3LBl2It5MZR2ox4jC95XDzhNWo9RQ7xVqXv3oOxc2lhGzhlHZa0
        P/JPsqNO4eFqp5nqXIkBb6YTs9QGr59byvqIYZqTPM9UXXRw1xt1Kik+/6myEnhcXpURWk
        keCAXWXLU7VgaDGTLwRHrJRvEQD3pf3SSIh8S/9KN6LDtmZj/Wh/LXa8GS0D/c/J+wfXI6
        q9TIlFrKa/lwd1v8bgjftiWNMVOs9JwoAr11Lt7TG0QrDEsSrhJt8TZ7K5/sjg==
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     linux-wireless@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Pavel Machek <pavel@denx.de>, johannes@sipsolutions.net
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        trivial@kernel.org,
        Linus =?utf-8?Q?L=C3=BCssing?= <ll@simonwunderlich.de>
Subject: Re: net/80211: simplify mesh code
Message-ID: <20200616083048.GA7241@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604214157.GA9737@amd>
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Acked-by: Linus Lüssing <ll@simonwunderlich.de>
