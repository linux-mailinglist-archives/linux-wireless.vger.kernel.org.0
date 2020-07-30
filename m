Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA86E2334CD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgG3Ow6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Ow6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:52:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35110C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:52:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19vU-00DaiW-9V; Thu, 30 Jul 2020 16:52:56 +0200
Message-ID: <85f77df8462fa4604a110ddfb590c9d7a42eda6f.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] nl80211: support 4-way handshake offloading for
 WPA/WPA2-PSK in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
Date:   Thu, 30 Jul 2020 16:52:55 +0200
In-Reply-To: <20200623134938.39997-2-chi-hsien.lin@cypress.com> (sfid-20200623_154955_835784_F9136359)
References: <20200623134938.39997-1-chi-hsien.lin@cypress.com>
         <20200623134938.39997-2-chi-hsien.lin@cypress.com>
         (sfid-20200623_154955_835784_F9136359)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-06-23 at 08:49 -0500, Chi-Hsien Lin wrote:
> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> Let drivers advertise support for AP-mode WPA/WPA2-PSK 4-way handshake
> offloading with a new NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK flag.
> 
> Extend use of NL80211_ATTR_PMK attribute indicating it might be passed
> as part of NL80211_CMD_START_AP command, and contain the PSK (which is
> the PMK, hence the name).
> 
> The driver is assumed to handle the 4-way handshake by itself in this
> case, instead of relying on userspace.

Applied.

johannes

