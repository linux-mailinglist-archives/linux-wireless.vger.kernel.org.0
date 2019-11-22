Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFAF1071EE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKVMEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:04:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44382 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKVMEY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:04:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY7fj-0002Yh-47; Fri, 22 Nov 2019 13:04:23 +0100
Message-ID: <23be17c6cddca53a2f3b945248516d3e7801a75c.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: set start_time_tsf/tsf_bssid for sw scans
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 13:04:19 +0100
In-Reply-To: <20191119221509.11370-1-prestwoj@gmail.com> (sfid-20191119_231813_756724_8FA90451)
References: <20191119221509.11370-1-prestwoj@gmail.com>
         (sfid-20191119_231813_756724_8FA90451)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-11-19 at 14:15 -0800, James Prestwood wrote:
> These values are already tracked so for the software scan path
> we can set these into scan_info so NL80211 reports it in
> TRIGGER_SCAN.

No.

> +		req->info.scan_start_tsf = req->scan_start;

These are two very different things.

johannes

