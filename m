Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26103C0A0B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 19:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfI0RI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 13:08:57 -0400
Received: from hz.preining.info ([95.216.25.247]:60308 "EHLO hz.preining.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0RI5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 13:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cXXJiq5YH8gtvqyF/dKyuBE39EX6k3QlWqRuTYG4LN4=; b=GTtV7HJcwRxqiMQYEqCe25dyLm
        nfImC55+5DAxthMfmua70/mWPOPdVJYHYW12kSGjKAhEvLdsx3ZNrGC0vRcwHCovXeZHHETmd7vnv
        9PO5tLucqiOFyOxLCqf8Ap3gtm5M9zh/0UCVTJZ7ljxVSNYqZBehN1zCud/Hl4QyE3w3Tt/pO4Ivz
        5+ydlxs3illFTYdE/Swl4n/ZXRf2luE+0a5rSCLT7xMOAYt+MRBsumNNLAhv45aogHlW/KnG0hcBE
        aArD9IqV77oBlNt61bwHK/V/uSkY0DLPJ6l/6IZ6pZqXFyio0a3g7jRPE03ZjZ00MrwiJoqmMFMRL
        kKRyXLew==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=burischnitzel.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1iDtjf-0000rL-Ox; Fri, 27 Sep 2019 17:08:52 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id 85C996971448; Sat, 28 Sep 2019 02:08:47 +0900 (JST)
Date:   Sat, 28 Sep 2019 02:08:47 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilw@linux.intel.com
Subject: Re: IWL AC 8260, kernel 5.3.*, many kernel WARNING
Message-ID: <20190927170847.laa7kii66d72il7y@burischnitzel.preining.info>
References: <20190927010452.b576njhcvgowasf3@burischnitzel.preining.info>
 <87blv5j4w1.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blv5j4w1.fsf@tynnyri.adurom.net>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Kalle,

On Fri, 27 Sep 2019, Kalle Valo wrote:
> I'm guessing this should fix it:
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=fddbfeece9c7882cc47754c7da460fe427e3e85b

Yes, I can confirm that with this patch added on top of 5.3.1 I don't
see the warnings anymore.

Thanks a lot

Norbert

--
PREINING Norbert                               http://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
