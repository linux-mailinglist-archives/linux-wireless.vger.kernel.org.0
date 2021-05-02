Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FDE370F1D
	for <lists+linux-wireless@lfdr.de>; Sun,  2 May 2021 22:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhEBUsa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 May 2021 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhEBUsa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 May 2021 16:48:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0853FC061756
        for <linux-wireless@vger.kernel.org>; Sun,  2 May 2021 13:47:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y124-20020a1c32820000b029010c93864955so4637584wmy.5
        for <linux-wireless@vger.kernel.org>; Sun, 02 May 2021 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wyv+AJDBJXfhuMypHrWLPCa+O4wXV6R5dC9sAiCj6jQ=;
        b=vRTAnhmLzGTF3e54S3YA4hpD2xQkBbcb4rqSbD7lTazG2v+3IQW0RleaTDBJm7Xdb3
         edcqbawqjf2eE+rBYnk+IO7tShE13i9muy7hlfoKaBVK+f5+qz6TwOTUAksaDLUqWD61
         llW4ytwxccbIvYMa68eoTlJHH3Pq797KE9wPfLYJhnq9+D4O28Bh3iNUpScCfeNxYwbL
         ELdhi+b0kO5av/rRMV/bQpHye9bom4VzPSgTHr4zg0yRVxDmmHJqWjje+vm+AOmugTTA
         kEPkbN1gp918Y/xQIruPBaLO108KLgaQbGd6PlYrDUAsMugh7tNDWQXJLUvVCjybuRCh
         3M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wyv+AJDBJXfhuMypHrWLPCa+O4wXV6R5dC9sAiCj6jQ=;
        b=mq59ynvDbtP/HX4X7FCRBa7aQNEgmWw7zBOqRXyzzkp9xhpuYAO3okkmo0lHNeERhc
         lLzXnfCDrB4PAwVYBHUFwcln2bS3D5C7I8PFvR4OPjxM5RQ++aWKkndn5Rzg8dIrOfLW
         dtw0TMCwJ3zryP7hbnn36dbGJlUS6clRlWKPhm1VHS8h2rfF5SQr/Yq0ayOv4x74Qlxt
         PjiXizgcGVgx0syW+uHGg2DBTtTHhFMSLS3Dc3g0m0z5dqN0JiKsZqlmAQF6QHpIJfZ1
         FoXL6ik+dDjCTGTLXzxV6VhTKF7p+okd6EXSfvevy9Hq1Rn8GFebzB6Gd5vRvNhIY5I0
         6gGw==
X-Gm-Message-State: AOAM530LY/wgFHhpwDr/o5JF8P9W/T9wNWxlQCEjZuEL1upa0Wc38CMd
        nXEYTt4jNoXOqV80tOl9GVQWMA==
X-Google-Smtp-Source: ABdhPJyu66cJfXZj/Vt8WfjO80X/+35rK+agDRc+Ljfkw/+5LIyZdHIlexZAbPIVifBUqnmcUZzxoQ==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr18315796wml.0.1619988456731;
        Sun, 02 May 2021 13:47:36 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id c8sm19286846wmr.48.2021.05.02.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 13:47:36 -0700 (PDT)
Date:   Sun, 2 May 2021 21:47:34 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Florian Westphal <fw@strlen.de>
Cc:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH] ath9k: ath9k_htc_rx_msg: return when sk_buff is too small
Message-ID: <YI8P5pp6b87OEoDo@equinox>
References: <20210502202545.1405-1-phil@philpotter.co.uk>
 <20210502202827.GG975@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210502202827.GG975@breakpoint.cc>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, May 02, 2021 at 10:28:27PM +0200, Florian Westphal wrote:
> Phillip Potter <phil@philpotter.co.uk> wrote:
> > At the start of ath9k_htc_rx_msg, we check to see if the skb pointer is
> > valid, but what we don't do is check if it is large enough to contain a
> > valid struct htc_frame_hdr. We should check for this and return, as the
> > buffer is invalid in this case. Fixes a KMSAN-found uninit-value bug
> > reported by syzbot at:
> > https://syzkaller.appspot.com/bug?id=7dccb7d9ad4251df1c49f370607a49e1f09644ee
> > 
> > Reported-by: syzbot+e4534e8c1c382508312c@syzkaller.appspotmail.com
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/net/wireless/ath/ath9k/htc_hst.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
> > index 510e61e97dbc..9dbfff7a388e 100644
> > --- a/drivers/net/wireless/ath/ath9k/htc_hst.c
> > +++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
> > @@ -403,7 +403,7 @@ void ath9k_htc_rx_msg(struct htc_target *htc_handle,
> >  	struct htc_endpoint *endpoint;
> >  	__be16 *msg_id;
> >  
> > -	if (!htc_handle || !skb)
> > +	if (!htc_handle || !skb || !pskb_may_pull(skb, sizeof(struct htc_frame_hdr)))
> >  		return;
> 
> This leaks the skb.

Dear Florian,

Thank you, and apologies, I shall resend. Not sure how I missed that.

Regards,
Phil
