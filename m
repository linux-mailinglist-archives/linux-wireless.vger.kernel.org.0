Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A062421E1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 12:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfFLKAf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 06:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731793AbfFLKAf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 06:00:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6204A30872C3;
        Wed, 12 Jun 2019 10:00:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0698E79451;
        Wed, 12 Jun 2019 10:00:22 +0000 (UTC)
Date:   Wed, 12 Jun 2019 12:00:16 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mt76: usb: fix rx A-MSDU support
Message-ID: <20190612100014.GA4431@redhat.com>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <52ea155d9889aa15df44b4910806b74fa2fd9056.1559293385.git.lorenzo@kernel.org>
 <20190612085844.GA2965@redhat.com>
 <20190612094519.GC8107@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612094519.GC8107@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 12 Jun 2019 10:00:35 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 12, 2019 at 11:45:21AM +0200, Lorenzo Bianconi wrote:
> > > +mt76u_build_rx_skb(u8 *data, int len, int buf_size,
> > > +		   int *nsgs)
> > > +{
> > > +	int data_len = min(len, MT_SKB_HEAD_LEN);

Oh, and this looks unneeded as well as for len < MT_SKB_HEAD_LEN=128
we will go through fast path.

> > mt7601u and iwlmvm just copy hdrlen + 8 and put the rest
> > of the buffer in fragment, which supose to be more efficient,
> > see comment in iwl_mvm_pass_packet_to_mac80211().
> 
> Right here we copy 128B instead of 32 but I think it is good to have L3 and L4
> header in the linear area of the skb since otherwise the stack will need to
> align them

Not sure if understand, I think aliment of L3 & L4 headers will be
the same, assuming ieee80211 header is aligned the same in fragment
buffer and in linear area. But if you think this is better to copy those
to linear area I'm ok with that.

Stanislaw
