Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8F45CEB
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfFNMf0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 08:35:26 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41288 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMf0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 08:35:26 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hblPM-0008Gc-G4; Fri, 14 Jun 2019 14:34:16 +0200
Message-ID: <3ef2937994bb0c4c9076b153deaf3c42e2e9a75f.camel@sipsolutions.net>
Subject: Re: [PATCH V2 4/6] mac80211: HE: add Spatial Reuse IE parsing
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Date:   Fri, 14 Jun 2019 14:34:15 +0200
In-Reply-To: <20190528114952.838-5-john@phrozen.org>
References: <20190528114952.838-1-john@phrozen.org>
         <20190528114952.838-5-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> +/*
> + * ieee80211_he_spr_size - calculate 802.11ax HE Spatial Reuse IE size
> + * @he_spr_ie: byte data of the He Spatial Reuse IE, stating from the the byte
> + *	after the ext ID byte. It is assumed that he_spr_ie has at least
> + *	sizeof(struct ieee80211_he_spr) bytes, checked already in
> + *	ieee802_11_parse_elems_crc()

That reference to mac80211 isn't really quite appropriate here - should
say something like "the caller must have validated this". This is a
lower layer usable by non-mac80211 as well.

johannes

