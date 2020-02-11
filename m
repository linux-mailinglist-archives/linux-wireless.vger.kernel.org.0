Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4983F158E7F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 13:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgBKM3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 07:29:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54511 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728352AbgBKM3u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 07:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581424189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hiPuXTgOHcXJNGa52VHxpCYWhKoBCevG6OXwx0R0HvY=;
        b=MF4/dqewO2FlR9u67VHefBi1nL13GkayhkURjI68T3m6et3x5KFQmX1zPG//0UHG+vwDaX
        IabaL9rmg3vd5LA/9N6MR9RdO2wGrN5KZ/lt+KE5IVnSu7mX5ZECykJyW3kvptAiuvuTd3
        0Q6CFF3F3ho58/wIccVXOSQHzgG3FtE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-E6V1fP4OO2ivfyLsfbF-hg-1; Tue, 11 Feb 2020 07:29:47 -0500
X-MC-Unique: E6V1fP4OO2ivfyLsfbF-hg-1
Received: by mail-lj1-f197.google.com with SMTP id j21so3689017lji.12
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2020 04:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hiPuXTgOHcXJNGa52VHxpCYWhKoBCevG6OXwx0R0HvY=;
        b=uatR4AOQ5NbwnHmbxRu/ZDoa7URyeZhN9nTdUqCiLHFzEs3AiRrNCCoWDPpQjiuV5G
         N9/UEqugxGWwRAguk9plGDxH60apMtBK/Te89dGIQScfs6UukCHDFPRIYaVYZKwvRUId
         PgBdXhPwzYUfKh2PkUap3Lg7hRAr6/lpYPs7nLmNjYEDy5RRjKzlQm4GgCeuD12kU6vw
         KXEyIpdXPZkUS6ieHTzLdAPiaCvPT3QBReCWr86wqz4P3jk7182x5rv/axyxblI75HwM
         hGgiVB30S78jZ1b57hoZcV0noMgPRXVQW3ImGqY+acnIuVj84dtZ7NttH/GJk6LLGF9M
         IErA==
X-Gm-Message-State: APjAAAX+yUiTSLA2sP0f/aSllEMbV7rGTITkgMzAsMR7Clw6tQcaoEGu
        4tiDHwd7F690SypCqxaAVjvQhM6I8MORGe1efQu8h4uGiDaf1dt8zo2ONbV7T6y1jCNe7W5LgIt
        QMOpzfQCle7NDpDUGH5jW7T04pVk=
X-Received: by 2002:a19:4208:: with SMTP id p8mr3533558lfa.160.1581424185787;
        Tue, 11 Feb 2020 04:29:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXp2k4BSZO+kjJba0MqyAAvg0nWW1mCavaTioQcXwlFk3I9Y7r965AJSYm8Ns26nE+Vxw96Q==
X-Received: by 2002:a19:4208:: with SMTP id p8mr3533548lfa.160.1581424185570;
        Tue, 11 Feb 2020 04:29:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r2sm2190813lff.63.2020.02.11.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:29:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 27CBF180365; Tue, 11 Feb 2020 13:29:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH 1/2] mac80211: allow setting queue_len for drivers not using wake_tx_queue
In-Reply-To: <20200211122605.13002-1-john@phrozen.org>
References: <20200211122605.13002-1-john@phrozen.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 11 Feb 2020 13:29:44 +0100
Message-ID: <87eev1b93b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> Currently a mac80211 driver can only set the txq_limit when using
> wake_tx_queue. Not all drivers use wake_tx_queue. This patch adds a new
> element to wiphy allowing a driver to set a custom tx_queue_len and the
> code that will apply it in case it is set. The current default is
> 1000 which is too low for ath11k when doing HE rates.

Fine, but we should really fix ath11k to do something smarter than a
fixed queue len... 4096 packets is 6 seconds of queueing at 8Mbps :/

-Toke

