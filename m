Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD95E8E75
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiIXQ0L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Sep 2022 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIXQ0I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Sep 2022 12:26:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4895AD4
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 09:26:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so8671337pjq.3
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nf/TNopwKhA3SuAUzkxD65hQdoK363QhRQCS+wUiixo=;
        b=MTrcpRmtk+EbhHce3q+zlg2MuEk7MubfhNmZm/kxs+7EJvA7mNxh+cinYxePsg/h6R
         VfvBgZrTST8LSjZpmSH70Hpf0dbPDG3adhU6k0pakjyAGq5KXlzpn5YAXhmlv78I9kKw
         bsTJtZEf/3IsZNeL5Bp3nbauVmGUadQkMGxao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nf/TNopwKhA3SuAUzkxD65hQdoK363QhRQCS+wUiixo=;
        b=NuA5OAM0NwUVSdTOFbo+WSZJVczyGakSoMUE5+Qn493MPwZa9I6mhK7wl15F4BY2kc
         sCU/UkndpZbniorZGBSipi5kSdpGQZdzRQ9mwlEjtLZrgFtSC5B2tuswS/XB/feQlxVC
         aZmmtwlfoOxtNvYc3ma3wcO4XQTVxeKKxCGtLjyPt5s2bmutjs/Myc1bEXy02vOU78/K
         f/PFww8xQ7EimdHa652eIdDHaIDvr7W3UEilynewEJWVejlDy1+5qObw2Yb5cvAspg0d
         Mq639DS4y3JnJiuzKCHPLQCgBILvjq0qQE5jHHsnafsxLIHXtjp96cioyFODtCFLL70M
         BOaQ==
X-Gm-Message-State: ACrzQf1+1+z2IlnT9mwX7mBGF4/Atn6NquneZpH9VOLe74ypNBMnk61H
        7VARK1zlez7RHS2B+qnBjaKKsQ==
X-Google-Smtp-Source: AMsMyM4hKcHlQYxI4al8+kxt5UInFkqmnU3b/eZLuYHZ1WZTaDBH1h6qGmxxvtz6sVCkeQflgDPGtg==
X-Received: by 2002:a17:903:110f:b0:178:ae31:ab2 with SMTP id n15-20020a170903110f00b00178ae310ab2mr14078264plh.89.1664036763455;
        Sat, 24 Sep 2022 09:26:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090aeb9200b001fb47692333sm3600904pjy.23.2022.09.24.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:26:02 -0700 (PDT)
Date:   Sat, 24 Sep 2022 09:26:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     18801353760@163.com, davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sfr@canb.auug.org.au,
        syzbot+473754e5af963cf014cf@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Add linux-next specific files for 20220923
Message-ID: <202209240905.F5654D7A5@keescook>
References: <20220924114425.95553-1-yin31149@gmail.com>
 <20220924155514.32408-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924155514.32408-1-yin31149@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 24, 2022 at 11:55:14PM +0800, Hawkins Jiawei wrote:
> > And as for the value of offsetof in calculating **offset**,
> > I wonder if we can use the macro defined in
> > include/linux/wireless.h as below, which makes code simplier:
> > #define IW_EV_COMPAT_LCP_LEN offsetof(struct __compat_iw_event, pointer)

Ah yes, that would be good.

> According to above code, it seems that kernel will saves enough memory
> (hdr_len + extra_len bytes) for payload structure in
> nla_reserve()(Please correct me if I am wrong), pointed by compat_event.
> So I wonder if we can use unsafe_memcpy(), to avoid unnecessary
> memcpy() check as below, which seems more simple:

I'd rather this was properly resolved with the creation of a real
flexible array so that when bounds tracking gets improved in the future,
the compiler can reason about it better. And, I think, it makes the code
more readable:

diff --git a/include/linux/wireless.h b/include/linux/wireless.h
index 2d1b54556eff..e0b4b46da63f 100644
--- a/include/linux/wireless.h
+++ b/include/linux/wireless.h
@@ -26,7 +26,10 @@ struct compat_iw_point {
 struct __compat_iw_event {
 	__u16		len;			/* Real length of this stuff */
 	__u16		cmd;			/* Wireless IOCTL */
-	compat_caddr_t	pointer;
+	union {
+		compat_caddr_t	pointer;
+		DECLARE_FLEX_ARRAY(__u8, ptr_bytes);
+	};
 };
 #define IW_EV_COMPAT_LCP_LEN offsetof(struct __compat_iw_event, pointer)
 #define IW_EV_COMPAT_POINT_OFF offsetof(struct compat_iw_point, length)
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 76a80a41615b..6079c8f4b634 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -468,6 +468,7 @@ void wireless_send_event(struct net_device *	dev,
 	struct __compat_iw_event *compat_event;
 	struct compat_iw_point compat_wrqu;
 	struct sk_buff *compskb;
+	int ptr_len;
 #endif
 
 	/*
@@ -582,6 +583,7 @@ void wireless_send_event(struct net_device *	dev,
 	nlmsg_end(skb, nlh);
 #ifdef CONFIG_COMPAT
 	hdr_len = compat_event_type_size[descr->header_type];
+	ptr_len = hdr_len - IW_EV_COMPAT_LCP_LEN;
 	event_len = hdr_len + extra_len;
 
 	compskb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
@@ -612,16 +614,15 @@ void wireless_send_event(struct net_device *	dev,
 	if (descr->header_type == IW_HEADER_TYPE_POINT) {
 		compat_wrqu.length = wrqu->data.length;
 		compat_wrqu.flags = wrqu->data.flags;
-		memcpy(&compat_event->pointer,
+		memcpy(compat_event->ptr_bytes,
 			((char *) &compat_wrqu) + IW_EV_COMPAT_POINT_OFF,
-			hdr_len - IW_EV_COMPAT_LCP_LEN);
+			ptr_len);
 		if (extra_len)
-			memcpy(((char *) compat_event) + hdr_len,
+			memcpy(compat_event->ptr_bytes + ptr_len,
 				extra, extra_len);
 	} else {
 		/* extra_len must be zero, so no if (extra) needed */
-		memcpy(&compat_event->pointer, wrqu,
-			hdr_len - IW_EV_COMPAT_LCP_LEN);
+		memcpy(compat_event->ptr_bytes, wrqu, ptr_len);
 	}
 
 	nlmsg_end(compskb, nlh);


-- 
Kees Cook
