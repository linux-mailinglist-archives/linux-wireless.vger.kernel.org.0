Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BCF33A2B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 23:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFCVud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 17:50:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34468 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCVud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 17:50:33 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hXueB-0001wL-NT
        for linux-wireless@vger.kernel.org; Mon, 03 Jun 2019 21:37:39 +0000
Received: by mail-io1-f71.google.com with SMTP id v187so14865896ioe.9
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2019 14:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iLPBbUzC4JoE+wBiRe6Z1S+IaQZZ2RZ35ohh/XlI2FA=;
        b=WsJCMHgAfp6gLc+epTtn3id61tROfu3TTZqqOy7SSEF0V69rOjcB33/hLZ9zj63N++
         G1EaUlKNcRjio1xwLnaKlrgbmDiWaZeLe0ECYptAvTg0A7cql3xqCDpyjG9sdE0Ca2HM
         8RUcWxWPhn96ItVBIBPxzeqvs9xaU+2DshcgxSMCNyLL04c2HCtETtBqCSVj+umMEhcr
         mqyz2hiWNdf4r4zkdAyMS7ESwfEcetOfgCZOOA2u5//GJXAcjl7MkQfINZemOYXONnu3
         +JveU9c3UNqe1vLtRXjLLATEqsrz8L/8SYAthuQKM8ME27NSLKlVH7oe7osppV+TlGmi
         mmtA==
X-Gm-Message-State: APjAAAVRwOHou1ZviN1Cxf4O1cl4OWygjDwNMVEP4LASxNez3iD2bJ5U
        81mvBv3hckJbVUPRvAg4GBMA+pB9OaU2iB3Kn5+vsuWNBzGEnEqiKkSu1s51pbnEJiSPsdvrdSs
        0dt7gLFAonN2U0hWCZy1h624KX4B/xy9+9Rhb4uoCs4ef
X-Received: by 2002:a24:dd93:: with SMTP id t141mr1197514itf.60.1559597858727;
        Mon, 03 Jun 2019 14:37:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0SzHO/IlUcFjJKA2h8oDfGk8C/vnXG3qNLyk9yG9juEA4bTxvOBE4C6zHXOHDhYMbNGi6/A==
X-Received: by 2002:a24:dd93:: with SMTP id t141mr1197497itf.60.1559597858423;
        Mon, 03 Jun 2019 14:37:38 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:9969:6580:f7d1:e724])
        by smtp.gmail.com with ESMTPSA id j1sm5475305iop.14.2019.06.03.14.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:37:37 -0700 (PDT)
Date:   Mon, 3 Jun 2019 16:37:36 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Expand 60 GHz band for Japan to 57-66 GHz
Message-ID: <20190603213736.GG4357@ubuntu-xps13>
References: <20190515132617.12852-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515132617.12852-1-seth.forshee@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 08:26:17AM -0500, Seth Forshee wrote:
> The official documents are not feely available, but based on
> summaries such as [1] and numerous third-party resources the 60
> GHz band in Japan has been 57-66 GHz for some time now. Update
> our rules accordingly.
> 
> [1] https://webstore.arib.or.jp/en/products/detail.php?product_id=288
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied.
