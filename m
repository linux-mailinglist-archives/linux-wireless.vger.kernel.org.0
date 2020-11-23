Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9181B2C12D6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbgKWSBi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 13:01:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:48542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbgKWSBh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 13:01:37 -0500
IronPort-SDR: mRVV6QwZPPbhrIYnYk4XPcr5iHAH279m9fgDpcm3/Kxlp7bdJjSE+2ejV4X9CYgAZEpwLVD/8J
 /nGVgVQSRFxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171911210"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="171911210"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 10:01:24 -0800
IronPort-SDR: MsDe+LYjN7TG23OEkvmmtHMZmPbqJYdHJcKYbJQVatrwwaDMQWr3/64N4q9lac123QLiRYaKVf
 Rq+rUZkFhx6A==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="327279699"
Received: from suygunge-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.108])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 10:01:20 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: Re: [PATCH 1/6] relay: allow the use of const callback structs
In-Reply-To: <20201119081120.GA6149@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20201118165320.26829-1-jani.nikula@intel.com> <20201119081120.GA6149@infradead.org>
Date:   Mon, 23 Nov 2020 20:01:17 +0200
Message-ID: <87pn44lzpu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 19 Nov 2020, Christoph Hellwig <hch@infradead.org> wrote:
> But taking one step back:  All instances implement create_buf_file
> and remove_buf_file, which makes sense as that is the prime aim
> of these methods.  So there is no point in making those optional.
> subbuf_start_callback is overriden by two instances, so making that
> optional totally makes sense.  buf_mapped and buf_unmapped are
> never overriden, so they should be removed entirely.
>
> More importantly there is no case that passes a NULL rchan_callbacks,
> which makes complete sense as it wouldn't even create a file.  So
> remove that case as well and just replace it with a sanity check in
> relay_open().

Many thanks for the feedback; sent v2 [1].

BR,
Jani.


[1] http://lore.kernel.org/r/cover.1606153547.git.jani.nikula@intel.com


-- 
Jani Nikula, Intel Open Source Graphics Center
