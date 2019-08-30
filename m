Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9794BA34FC
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfH3Kc5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 06:32:57 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34486 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfH3Kc5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 06:32:57 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3eDA-0003sV-4G; Fri, 30 Aug 2019 12:32:56 +0200
Message-ID: <420dcc9c0023791b72dba2d776045fc0b025597a.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Convert 6 GHz channel frequency to channel
 number
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Amar Singhal <asinghal@codeaurora.org>, jouni@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, jjohnson@codeaurora.org,
        rmanohar@codeaurora.org
Date:   Fri, 30 Aug 2019 12:32:55 +0200
In-Reply-To: <1567117290-19295-1-git-send-email-asinghal@codeaurora.org>
References: <1567117290-19295-1-git-send-email-asinghal@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-29 at 15:21 -0700, Amar Singhal wrote:
> Enhance function ieee80211_frequency_to_channel by adding 6 GHz
> channels.

Wait, this is already supported, no? Just implemented slightly
differently?

johannes

