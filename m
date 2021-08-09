Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961043E434B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhHIJwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 05:52:32 -0400
Received: from ixit.cz ([94.230.151.217]:45390 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232944AbhHIJwb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 05:52:31 -0400
Received: from [192.168.1.138] (ixit.cz [94.230.151.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 010922029F;
        Mon,  9 Aug 2021 11:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1628502729; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=zMMvPYXCWwg1ECXuJ65Ce2QQL+GNmPxWmXQL8VjJT+A=;
        b=howMU3VFC/t653oHDrbc9ZILio1UPU+Z1yl3/1JY3PGCRGCy9IbsCRLWrayvM02TYCZaZM
        m7P3PfTT+5FcjDnGL9l1VIEA/SMw8lsE8sxphkAGMYJ2Q7FMkI3fvaXupq10Q8nvpaby0K
        NBqjWP5KzA6wlVl8zJEMZXDz85wA4bg=
Date:   Mon, 09 Aug 2021 11:51:03 +0200
From:   David Heidelberg <david@ixit.cz>
Reply-To: 1608618887-8857-1-git-send-email-miaoqing@codeaurora.org
Subject: Re: [PATCH v2] ath10k: fix wmi mgmt tx queue full due to race
 condition
To:     miaoqing@codeaurora.org, briannorris@chromium.org,
        kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Message-Id: <3PGKXQ.OUNHZGPTI7091@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello all,

since I noticed this issue is very common (at least for me and some 
others) on 4.14 kernels [1] [2] would you think that backporting this 
patch into stable would make sense? I assume that at some point it 
could help some OpenWRT/LEDE and other devices (since for Turris it'll 
be most likely backported anyway).

Thank you for the working on this!
David

[1] 
https://forum.turris.cz/t/5-2-4-patch-wifi-fails-after-while-wmi-mgmt-tx-queue-is-full/15510
[2] https://forum.turris.cz/t/unstable-wifi-on-mox-b/11065/



