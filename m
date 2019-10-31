Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410A8EAB60
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 09:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfJaILO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 04:11:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50312 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJaILO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 04:11:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iQ5Y1-0004M4-2Z; Thu, 31 Oct 2019 09:11:13 +0100
Message-ID: <c20b5712d610b58bf153ba4aa6ed5f2764af424d.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] sta_info: fix insane values in iw sta dump
 "inactive time"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ahmed Zaki <anzaki@gmail.com>, linux-wireless@vger.kernel.org
Date:   Thu, 31 Oct 2019 09:11:11 +0100
In-Reply-To: <20191030213153.3196-2-anzaki@gmail.com> (sfid-20191030_223241_218733_F012DFCA)
References: <20191030213153.3196-1-anzaki@gmail.com>
         <20191030213153.3196-2-anzaki@gmail.com>
         (sfid-20191030_223241_218733_F012DFCA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-10-30 at 15:31 -0600, Ahmed Zaki wrote:
> In the first 5 mins after boot (initial jiffies),
> ieee80211_sta_last_active() returns zero in case last_ack is zero. This
> leads to insane values appearing in "inactive time".
> 
> Fix by returning last_rx if last_ack == 0.

Please read

https://wireless.wiki.kernel.org/en/developers/Documentation/SubmittingPatches

johannes


