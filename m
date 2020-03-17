Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD27188BD6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCQROW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 13:14:22 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:38626 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgCQROV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 13:14:21 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 176DA13C344;
        Tue, 17 Mar 2020 10:14:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 176DA13C344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1584465261;
        bh=StU1Y3ZiUqQb3GNkuDIJ1U1JRS8KyGStkkeBtQGM4bI=;
        h=To:Cc:From:Subject:Date:From;
        b=Brm+AHMIaHBFr/ABRoNixx61bKI8y4FvlZFm4T0AaRtY7R5zMozi/T/jXlPfyB2SL
         woUvtO7o47oKJSjMnPCQ2mpjijaMxmqJT+A3fVibIUEvw9vPYLp7/68valVY+WEW1W
         VHtLMMCgQheYrALSSsyvoWmiMMj6TAmOLGz5kwp4=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Luca Coelho <luca@coelho.fi>
From:   Ben Greear <greearb@candelatech.com>
Subject: How to set AX200 to be a 1x1 antenna radio?
Organization: Candela Technologies
Message-ID: <3bce6845-ee07-e5b6-6ccb-3366ab1493cd@candelatech.com>
Date:   Tue, 17 Mar 2020 10:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Any suggestions for how to set the AX200 to act like a 1x1 device?  I can try
writing a driver patch if anyone can point me to how to make the firmware do this...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

