Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20D11E0CB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLMJcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:32:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44836 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLMJcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:32:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ifhJ8-009bDv-0v; Fri, 13 Dec 2019 10:32:22 +0100
Message-ID: <2e5f60bc56e930e599cd5c5ed1925e41dcc90f14.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: he_support was not set when bringing up a HE
 mesh interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Sven Eckelmann <seckelmann@datto.com>
Date:   Fri, 13 Dec 2019 10:32:15 +0100
In-Reply-To: <20191213092636.17736-1-john@phrozen.org>
References: <20191213092636.17736-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> 
> The he_support flag inside bss_conf was not set when a HE mesh interface
> gets created. This causes the drivers to not set the HW up correctly.

This is all wrong ... it doesn't even explain the change.

Also, the subject? Really? I know you can all do better.

> Fixes: 60ad72da55ac ("mac80211: implement HE support for mesh")
> 
> Cc: Sven Eckelmann <seckelmann@datto.com>

The fixes should also be part of the footer.

johannes


