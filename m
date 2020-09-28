Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967FA27AC7A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1LOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1LOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:14:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC10C061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:14:38 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMr77-00CRjb-5U; Mon, 28 Sep 2020 13:14:37 +0200
Message-ID: <bfeef8bd4711a954e2f4c399a09855ad7d97371c.camel@sipsolutions.net>
Subject: Re: [RFCv3 3/3] nl80211: Send large new_wiphy events
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 13:14:36 +0200
In-Reply-To: <d97f7b4b-6508-4773-b13d-dab052349f47@gmail.com> (sfid-20190911_171724_324908_4CC4C3CC)
References: <20190906154303.9303-1-denkenz@gmail.com>
         <20190906154303.9303-3-denkenz@gmail.com>
         <127c19b1855302a467a1bdbf2f25f625a0254d9e.camel@sipsolutions.net>
         <f48bdad3-f9f8-20b7-b6ff-6248368a7ae1@gmail.com>
         <0b12af1b27954f62a5ce715f95176d1f0ff393a3.camel@sipsolutions.net>
         <d97f7b4b-6508-4773-b13d-dab052349f47@gmail.com>
         (sfid-20190911_171724_324908_4CC4C3CC)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> Ah, now I see what you want.  Sure I will take care of this in v4.

I just remembered this because of Martin Willi's patch, and see now that
I actually just did the first patch of this series again while looking
into it ...

Did you ever make a v4 of this?

johannes

