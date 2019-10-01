Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AC5C311F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfJAKT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 06:19:28 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58796 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfJAKT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 06:19:28 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFFFf-00057v-KI; Tue, 01 Oct 2019 12:19:27 +0200
Message-ID: <20985660fd0872db1511948bd42cd925cef13cee.camel@sipsolutions.net>
Subject: Re: [PATCH V3 0/4] Enable virtual time-based airtime scheduler
 support on ath10k
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org
Date:   Tue, 01 Oct 2019 12:19:26 +0200
In-Reply-To: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org> (sfid-20190923_092024_747005_B4B11EDF)
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
         (sfid-20190923_092024_747005_B4B11EDF)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-09-23 at 15:19 +0800, Yibo Zhao wrote:
> This series fix some issues when enabling virtual time-based airtime scheduler on ath10k.
> 
Given the lengthy discussion here and also over in the related thread
about AQL, I'm assuming you're going to repost this eventually.

johannes

