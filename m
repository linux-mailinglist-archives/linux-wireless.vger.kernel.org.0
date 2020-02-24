Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A280C16A68E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 13:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgBXM6Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 07:58:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:33668 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXM6Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 07:58:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j6DJW-006cqu-TT; Mon, 24 Feb 2020 13:58:23 +0100
Message-ID: <b4771f673d785d7c73564f30a272062860b9d7c6.camel@sipsolutions.net>
Subject: Re: [PATCHv10 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 24 Feb 2020 13:58:21 +0100
In-Reply-To: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
References: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've finally applied most of this.

However, I made some significant changes to how the feature is
advertised to userspace to simplify the code; I also made some other
changes all over, please check the patch I inserted in the middle and
the rebase of the others.

I also didn't apply the last patch so please respin that with the new
code, but I don't like the fact that the driver needs to free the buffer
there - please find a different solution for that.

johannes

