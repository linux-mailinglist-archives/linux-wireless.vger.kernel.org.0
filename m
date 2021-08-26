Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA53F85F4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbhHZK6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 06:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbhHZK6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 06:58:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749CAC061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0GCw62geJv8DFsg2d0ecUX2tUwfJ+4AXx5psLdYUqE4=;
        t=1629975465; x=1631185065; b=YqDk/1eV13QS4Cs+tRjhln9//Q4XT1gyjNM0CCPz6aKqXh1
        vJ3NHI+GmA0xiFuH5qlaiCnmIHFhORprMqU4HMqqzHg/tQPLG7QxLsDcVSML8AMtqP70Xr3CqWUGd
        t7Blbe3znHRBy0wBrGBLptlSUi+TMc0gT3NpDKO2GryWPU+eruO1xgBbLx8CQcbQfaxb20ppxzyn2
        llzF1fj9oCZ3lr7K+cfXnfLs5VWTBguThM2Wp4BDpWpijRwk5ilMBv2dYtawR4XESTGBxUEx+4p6p
        V46jDdryoUo0aVVl1N7Z2mIMi0tGcFaK57N6NdqGY4JViwRmly1vbgC3Q4g+wcug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJD4m-00G7Ml-Lo; Thu, 26 Aug 2021 12:57:40 +0200
Message-ID: <5c85b2bcfbffb617c5aa3f55e7ae94a1ab4df743.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 12:57:39 +0200
In-Reply-To: <fe21853e8c9a73632e0ca860eef00296@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
         <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
         <fe21853e8c9a73632e0ca860eef00296@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-08-26 at 18:50 +0800, Wen Gong wrote:
> > 
> it is memset here i this patch:

Oops, missed that.

But is that really a good place for it? Doesn't really seem to belong to
assigning a channel context - maybe put it into set_disassoc()?

johannes



