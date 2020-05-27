Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2971E45D7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbgE0O2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbgE0O2o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:28:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43409C08C5C1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 07:28:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdx2w-0049im-IW; Wed, 27 May 2020 16:28:42 +0200
Message-ID: <bfc63efc0c4b5f5ef290aa9c26c8253069c2ea80.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/11] mac80211: add HE 6 GHz Band Capabilities into
 parse extension
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 27 May 2020 16:28:40 +0200
In-Reply-To: <1589399105-25472-4-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-4-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-13 at 12:44 -0700, Rajkumar Manoharan wrote:
> Handle 6 GHz band capability element parsing for association.

Yeah, pretty much have the same here...

johannes

