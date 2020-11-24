Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358B72C21F2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 10:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgKXJmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 04:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKXJmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 04:42:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C1CC0613D6;
        Tue, 24 Nov 2020 01:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XrQsdiALGmObA9uvgwwmDB5EeVLjA/XElNTDSKt+EP0=; b=i3ortBeZ87lHuSVV4Yu3uRWhw8
        jhRn3hpaGl3cPSFB/Z0bMrmnxCyrOxGzjqV+DFj0wcFW5GyvFWcI9kdjqf9y1WW5uEyvVFoYZVruj
        K7KJwA6ihkFwQTV8fu8p12XS7JDUc0Kov05rOyUquV75ifLe7l5QIQ2HqFJCo6S5JgerpXhpTiZLD
        6qjkW0oh3gRTaV7lnGW69Mm7eoFYjLBebRotqlCIs2uMSO8p20JCTonVUoF7N9vrfpDPI6HWNRRRt
        gJqqqSsMMizO0HFncY21rzTtjUChI94vYYhHLYuZis5BwMbsayBHfV7VDJaEmAOzPF17Pk/RS+RK9
        haUKydVA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUqa-0000Rq-Qp; Tue, 24 Nov 2020 09:42:52 +0000
Date:   Tue, 24 Nov 2020 09:42:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Kalle Valo <kvalo@codeaurora.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 8/9] ath9k: make relay callbacks const
Message-ID: <20201124094252.GH31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <7db0286c428f3a478dd7544afef04a3b131f1aa0.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db0286c428f3a478dd7544afef04a3b131f1aa0.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:28PM +0200, Jani Nikula wrote:
> Now that relay_open() accepts const callbacks, make relay callbacks
> const.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
