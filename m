Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43015D453
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 10:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgBNJGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 04:06:05 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:39056 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgBNJGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 04:06:05 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2WvC-00BDFb-Mp; Fri, 14 Feb 2020 10:06:02 +0100
Message-ID: <a9447df7bb83222d04199eef7c804431b877e773.camel@sipsolutions.net>
Subject: Re: [PATCH 23/23] mac80211: Properly set the SMPS mode for 6GHz
 station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:06:01 +0100
In-Reply-To: <20200131111300.891737-24-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
         <20200131111300.891737-24-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-01-31 at 13:13 +0200, Luca Coelho wrote:
> From: Shaul Triebitz <shaul.triebitz@intel.com>
> 
> The managed interface SMPS mode was not set in the HE 6GHz
> capabilities IE. Set it.
> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

This author/s-o-b chain makes no sense...

> + * @twt_protected: does this BSS support protected TWT frame

and this patch is not related to SMPS mode at all, Luca, what happened
here?!

johannes

