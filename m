Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9731A302C04
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbhAYTwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 14:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732155AbhAYTwi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 14:52:38 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E80C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 11:51:57 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l47ty-00BYIp-JB; Mon, 25 Jan 2021 20:51:54 +0100
Message-ID: <2027106c42a27eb850217eaae928b7d36e345f4c.camel@sipsolutions.net>
Subject: Re: [PATCHv2] cfg80211: Skip key deletion for open associations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     chaitanya.mgit@gmail.com, linux-wireless@vger.kernel.org
Cc:     Chaitanya Tata <chaitanya.tata@bluwireless.com>
Date:   Mon, 25 Jan 2021 20:51:53 +0100
In-Reply-To: <20210125192046.975-1-chaitanya.mgit@gmail.com> (sfid-20210125_202058_832502_8683DD33)
References: <20210125192046.975-1-chaitanya.mgit@gmail.com>
         (sfid-20210125_202058_832502_8683DD33)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-01-26 at 00:50 +0530, chaitanya.mgit@gmail.com wrote:
> From: Chaitanya Tata <chaitanya.mgit@gmail.com>
> 
> From: Chaitanya Tata <chaitanya.mgit@gmail.com>

That's broken, please check your git mail setup.

>  	 * Delete all the keys ... pairwise keys can't really
>  	 * exist any more anyway, but default keys might.
>  	 */
> -	if (rdev->ops->del_key) {
> +	if (wdev->connect_keys && rdev->ops->del_key) {
> 

This is wrong, wdev->connect_keys is not needed to make a secure
connection.

johannes

