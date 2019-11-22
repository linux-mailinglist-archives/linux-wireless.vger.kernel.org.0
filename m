Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0010721F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKVM2A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:28:00 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44652 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVM2A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:28:00 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY82Y-00033L-FQ; Fri, 22 Nov 2019 13:27:58 +0100
Message-ID: <c6f0bd8c87375824e55dc105a78c4479683139a6.camel@sipsolutions.net>
Subject: Re: [PATCH v11 2/4] mac80211: Import airtime calculation code from
 mt76
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, john@phrozen.org,
        lorenzo@kernel.org, rmanohar@codeaurora.org, kevinhayes@google.com
Date:   Fri, 22 Nov 2019 13:27:55 +0100
In-Reply-To: <20191119060610.76681-3-kyan@google.com> (sfid-20191119_070625_522904_ADC19544)
References: <20191119060610.76681-1-kyan@google.com>
         <20191119060610.76681-3-kyan@google.com>
         (sfid-20191119_070625_522904_ADC19544)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-11-18 at 22:06 -0800, Kan Yan wrote:
> 
> +#define HE_GROUP_IDX(_streams, _gi, _bw)				\
> +	(IEEE80211_HE_GROUP_0 +					\
> +	 IEEE80211_HE_MAX_STREAMS * 2 * (_bw) +			\
> +	 IEEE80211_HE_MAX_STREAMS * (_gi) +				\
> +	 (_streams) - 1)

I'll also fix that to be " * 3" instead of 2, since there are 3 possible
_gi values.

johannes

