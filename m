Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3066DBFBA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404297AbfJRITn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 04:19:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50130 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403773AbfJRITn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 04:19:43 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLNU5-00020l-0D; Fri, 18 Oct 2019 11:19:41 +0300
Message-ID: <0421e9e5452ebf7b396e8237e52fd2bdcae5fa1b.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Oct 2019 11:19:39 +0300
In-Reply-To: <87lftlkvup.fsf@codeaurora.org>
References: <20191012162924.19848-1-luca@coelho.fi>
         <20191012192536.797f1ede5077.Ice818674f107105ae05a6f561263c0896d49de2c@changeid>
         <87lftlkvup.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 05/13] iwlwifi: dbg: prefer struct copy to memcpy()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-10-16 at 10:11 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > ifxes=Ic930239af4832ecb04afbf92840c99dfd726eebe
> > 
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> Quite cryptic commit log :)

Hah! Sorry... there was a typo in our "fixes" tag, which caused my
script not to trim it out and additionally it was merged without a
proper description.

If the "fixes" didn't have a typo, this patch would have been squashed
with the one it's fixing, so not having a commit message wouldn't
matter.

It's supposed to fix "iwlwifi: dbg_ini: use new trigger TLV in dump
flow", so I'll just squash it into that one.

--
Luca.

