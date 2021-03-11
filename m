Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2E3380F4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Mar 2021 23:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhCKWyi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Mar 2021 17:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCKWyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Mar 2021 17:54:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFADFC061574
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 14:54:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bt4so4201770pjb.5
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=JsyBj8TgECVSpAqmB3OvELcBoQCOHvZ23+pQb4do1r4=;
        b=MI/Xns8EOVDhIxXQhqeqzbvHBIz+1NfMQsILVWbYrEjPInGpR6AwBAmx6/e4JriBJk
         l8ZJOMVXI4Bj9Z0usXsEewvWUdyfzEX4hJ+ud2Rw7b/ftXAxupS+s+wk6KlORDGZOjuZ
         Pir/gJw/+fQTmwVyYp88jvRasa6ReLmwwRKtBs8CRRj4kvAV7GQQ0VCNjWiZmDDRtJ8L
         7FZjvDOD9qWjD+PiJfPCOt+jc/zYuotUGcxA/Nwkbj0qxxbo3gRZuddzHKNuDM4VMeqC
         EDdjFmbJK9V8wrARQoNQ4hXhQwskKQImC04b+xYRAFpf6lXfHSYmTMvpUWkshTFV+3p5
         Ls8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JsyBj8TgECVSpAqmB3OvELcBoQCOHvZ23+pQb4do1r4=;
        b=TXz0HnDQGfIOOnKYy6B3fyZzARK1jue1oGsf/uWpeZFq4uAANg7AU2dNzc2nKsCC4f
         tQ2O2c+MRhXoJi74ueBFRUI+Lf+yV3FN3u+QbznVlF5dkEkJdd6VkksqdbJZX4MDJlOU
         pDCsDKNss2C5bFUIOg/lgFE8AlgL2ybf5Td+7wUyASYZaIec9J94a4JfoTnn/Q5XbqFD
         3P7EerER4eGYbxBWO5DJWTtQa8/9U+Bg3Zy9s0oFUtzvX+pZTL/7YfElWR9iamuKEuTA
         GCByYqrxOqWWKB9yjxTgsVrRBbzJaOOOvEqZvgFMTDqW5wx4EVWb52nU7ly/R/yxsMOD
         RI7A==
X-Gm-Message-State: AOAM5314Wf/lL9l0YSh/cHMbcSJSH9cN6iBmd401EAHaF/U9+Uh6EKxM
        nE2ryWTtH9voTajuRbnlSPATKdA1W6M=
X-Google-Smtp-Source: ABdhPJzlKebWzK0DwmruHobFtbPNO0mAKjhw4DUNHsPygdUoG97OYUkr2rMxquxt44SpuBOmPwKPOQ==
X-Received: by 2002:a17:902:b182:b029:e6:5e:f2ce with SMTP id s2-20020a170902b182b02900e6005ef2cemr10536254plr.50.1615503273535;
        Thu, 11 Mar 2021 14:54:33 -0800 (PST)
Received: from jprestwo-xps ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id x7sm3405343pff.12.2021.03.11.14.54.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 14:54:33 -0800 (PST)
Message-ID: <f38178e49d50486bbf29e46b1514b92ff8681814.camel@gmail.com>
Subject: Re: brcmfmac: Getting IEs from CMD_ROAM
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 11 Mar 2021 14:54:32 -0800
In-Reply-To: <76d03f421dd7db33755675e424541a64aac95310.camel@gmail.com>
References: <76d03f421dd7db33755675e424541a64aac95310.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry for the noise, apparently you do a GET_SCAN after CMD_ROAM to
obtain this info. I'll be writing a docs change soon to describe this.

On Thu, 2021-03-11 at 14:00 -0800, James Prestwood wrote:
> Hi,
> 
> Adding FW roaming support to IWD has led me down this rabbit hole
> with
> CMD_ROAM, and I am attempting to understand how wpa_supplicant
> handles
> this. The brcmfmac card I am using sends a CMD_ROAM event which
> contains some response IEs but no RSN element (nor any scan
> information
> like frequency, rssi, etc, thats another topic). This prevents the
> supplicant from being able to complete the 4-way handshake.
> 
> Now, I have a dirty hack to re-use the previous BSS's RSN element
> which
> *works* but this will break e.g. roaming between WPA1 <-> WPA2, plus
> 802.11 requires that the authenticator IE is verified during the 4-
> way, 
> which cant reliably happen if we just use an arbitrary RSN element
> from
> another BSS.
> 
> Is this a known issue? I'm trying to read the code in wpa_supplicant
> and its making my head spin. It does attempt to parse the RSN element
> from CMD_ROAM, but I expect that fails since its not included. If it
> doesn't get it from CMD_ROAM where does it get it from? Or does it
> spoof it like I am?
> 
> Thanks,
> James
> 

