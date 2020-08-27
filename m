Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69F2544E9
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgH0MYC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgH0MXm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 08:23:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED677C061235
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:23:41 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBGwO-00BaHo-7g; Thu, 27 Aug 2020 14:23:40 +0200
Message-ID: <98a1925306e863c75d818242f3c11b10be6bd899.camel@sipsolutions.net>
Subject: Re: [PATCH V5 2/5] mac80211: rename csa counters to countdown
 counters
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 27 Aug 2020 14:23:39 +0200
In-Reply-To: <20200826055650.1101224-2-john@phrozen.org> (sfid-20200826_075709_513561_34041B4E)
References: <20200826055650.1101224-1-john@phrozen.org>
         <20200826055650.1101224-2-john@phrozen.org>
         (sfid-20200826_075709_513561_34041B4E)
Content-Type: text/plain
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Applied the first two of this set.

