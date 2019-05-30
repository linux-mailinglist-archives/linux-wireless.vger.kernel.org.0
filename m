Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A3F30126
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfE3Rn1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 13:43:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Rn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 13:43:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 07DF5604D4; Thu, 30 May 2019 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559238207;
        bh=no5ZQcCRRsEmp6RRYQSrMgwzYaEgM1bWoGevzG1+9+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U+UlTkHt1DlEha2VUY6k0mfGeTaCk+lF/lIwJ/Dwn+HSsTkpQ21IFTtUVLMhSiz8b
         274+fNwae8bUQRpC6w10qAXYMuhQeuCqqf5sZLDtOkJjO5pOKNFUz2CMyQO13/d2Dq
         2g/Xmf1vGsy+EKa09S5tMnCZgxqepdNxkqoKwmAM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AF0786019D;
        Thu, 30 May 2019 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559238206;
        bh=no5ZQcCRRsEmp6RRYQSrMgwzYaEgM1bWoGevzG1+9+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z8KLr1g6FJcLYzjOk9JOEIv74/JRghiMQjNIzfXMIxyeHnsyoQoGhncxoHBgcMirp
         ABRkiK+TV63e5L5FB29WKJM3VSTQXdP652tGZbmnfQUXQdiL/4LDSgb+bdptvqLIcN
         OXHWuYtpy7e9mMNxIpnj/Z+FBumAWjhpXkLH5As0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 May 2019 10:43:26 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [RFC 1/8] nl80211: add 6GHz band definition to enum nl80211_band
In-Reply-To: <16b097efa48.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558353645-18119-2-git-send-email-arend.vanspriel@broadcom.com>
 <d27aac46e682d6cb93ac97df0073818c@codeaurora.org>
 <16b097efa48.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Message-ID: <284014c56afe555b5fda60a8467f8e6a@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-30 09:07, Arend Van Spriel wrote:
> Sigh! Obviously that is a concern. Johannes already mentioned it.

Sorry, overlooked his comment on the [0/8] patch. I'll climb back under 
my rock.
